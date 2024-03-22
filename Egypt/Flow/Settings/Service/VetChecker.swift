//
//  Checker.swift
//  Egypt
//
//  Created by Dmitriy Holovnia on 22.03.2024.
//

import Foundation

import Foundation
import AppsFlyerLib
import AdSupport
import AppTrackingTransparency

struct JWTPayload: Decodable {
    let payload: Payload
}

struct Payload: Decodable {
    let direction: String?
    let role: String
}

class VetChecker: NSObject {

    // MARK: - Public Properties

    var completionHandler: ((URL?) -> Void)?

    // MARK: - Private Properties

    private var token: String!

    // MARK: - Init
    
    func setup(token: String) {
        self.token = token
        configureAppsFlyer()
    }

    // MARK: - Private Methodes

    private func configureAppsFlyer() {
        AppsFlyerLib.shared().appsFlyerDevKey = Settings.appsFlyerKey
        AppsFlyerLib.shared().appleAppID = Settings.appsFlyerId
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().start()
//        AppsFlyerLib.shared().isDebug = true
    }

    private func prepare(_ dic: [AnyHashable : Any]) {
        guard let payload = checkPayload(token: token) else { return }
        var tmp = dic
        tmp["appID"] = Settings.appsFlyerId
        tmp["affKey"] = Settings.appsFlyerKey
        guard let link = payload.direction else {
            completionHandler?(nil)
            return
        }
        var queryItems: [URLQueryItem] = []
        let afid = AppsFlyerLib.shared().getAppsFlyerUID()
        if let idfa = Settings.idfa {
            queryItems.append(URLQueryItem(name: "adid", value: idfa))
        }
        queryItems.append(URLQueryItem(name: "afid", value: afid))
        queryItems.append(URLQueryItem(name: "aftoken", value: Settings.appsFlyerKey))
        queryItems.append(URLQueryItem(name: "appid", value: Settings.appsFlyerId))
        if let company = dic["campaign"] as? String {
            let companyNames = company.components(separatedBy: "_")
            companyNames.indices.forEach {
                queryItems.append(URLQueryItem(name: "sub\($0 + 1)", value: companyNames[$0]))
            }
        }
        var baseURL = URLComponents(string: link)!
        if let initialQueryItems = baseURL.queryItems {
            queryItems = initialQueryItems + queryItems
        }
        baseURL.queryItems = queryItems
        completionHandler?(baseURL.url)
    }

    private func checkPayload(token: String) -> Payload? {
        let component = token.components(separatedBy: ".")[1]
        var base64 = component
        
        switch (base64.utf16.count % 4) {
        case 2:
            base64 = "\(base64)=="
        case 3:
            base64 = "\(base64)="
        default:
            break
        }
        guard let dataToDecode = Data(base64Encoded: base64, options: []) else { return nil }
        
        let decoder = JSONDecoder()
        guard let rawData = try? decoder.decode(JWTPayload.self, from: dataToDecode) else {
            return nil
        }
        return rawData.payload
    }
}

extension VetChecker: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        prepare(conversionInfo)
        debugPrint("AppsFlyer conversionInfo: \(conversionInfo)")
    }

    func onConversionDataFail(_ error: Error) {
        prepare(["afStatus": "error"])
        debugPrint("AppsFlyer error: \(error.localizedDescription)")
    }
}

// MARK: - Helper

private extension [AnyHashable : Any] {
    var toItems: [URLQueryItem] {
        self.map {
            URLQueryItem(name: "\($0.key)".replacingOccurrences(of: " ", with: "_"),
                         value: "\($0.value)".replacingOccurrences(of: " ", with: "_"))
        }
    }
}

