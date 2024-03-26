//
//  LoadingVC.swift
//  Egypt
//

import UIKit
import OneSignalFramework
import AppTrackingTransparency
import AdSupport

class LoadingVC: UIViewController {
    
    private let authService = AuthRequestService.shared
    private let checker = VetChecker()
    
    private var contentView: LoadingView {
        view as? LoadingView ?? LoadingView()
    }
    
    override func loadView() {
        view = LoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateAndCheckToken()
        animateProgressBar()
        checker.completionHandler = { [weak self] url in
            guard let self = self,
                  let url else { return }
            print("Handler \(url.absoluteString)")
            let vet = VetContrller(liq: url)
            vet.modalPresentationStyle = .fullScreen
            present(vet, animated: false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?.requestTrackingAuthorization()
        }
    }
    
    func animateProgressBar() {
        UIView.animate(withDuration: 3.5) {
            // Установите конечное значение прогресса
            self.contentView.loadView.setProgress(1.0, animated: true)
        }
    }
    
    func presendHome() {
        let vc = HomeVC()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    private func showVeqVC(token: String) {
        checker.setup(token: token)
    }
    
    private func authenticateAndCheckToken() {
        Task {
            do {
                let response = try await authService.authenticate()
                UserMemory.shared.token = response.token
                checkToken()
                createUserIfNeeded()
                if let token = response.token,
                   checkToken(token: token) {
                    showVeqVC(token: token)
                } else {
                    presendHome()
                }
            } catch {
                print("Authentication failed. Error: \(error)")
                presendHome()
            }
        }
    }

    private func checkToken() {
        guard let token = authService.token else {
            return
        }
        print("TOKEN - \(token)")
    }

    private func createUserIfNeeded() {
        if UserMemory.shared.userID == nil {
            UserApi.createUser(payload: CreateUserPayload(name: nil, score: 0)) { result in
                switch result {
                case .success(let user):
                    UserMemory.shared.userID = user.id
                case .failure(let error):
                    print("failure: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func requestTrackingAuthorization() {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { [weak self] status in
            if status == .authorized {
                Settings.idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            }
            print("Tracking status: \(status.rawValue)")
            DispatchQueue.main.async {
                OneSignal.initialize(Settings.oneSignalId)
                OneSignal.Notifications.requestPermission({ accepted in
                    print("User accepted notifications: \(accepted)")
                }, fallbackToSettings: true)
            }
            self?.authenticateAndCheckToken()
        })
    }
    
    private func checkToken(token: String) -> Bool {
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
        guard let dataToDecode = Data(base64Encoded: base64, options: []) else { return false }
        
        let decoder = JSONDecoder()
        guard let rawData = try? decoder.decode(JWTPayload.self, from: dataToDecode) else {
            return false
        }
        return rawData.payload.direction != nil
    }
}

