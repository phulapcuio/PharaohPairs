//
//  LoadingVC.swift
//  Egypt
//

import Foundation
import UIKit

class LoadingVC: UIViewController {
    
    private let authService = AuthRequestService.shared
    
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
    
    private func authenticateAndCheckToken() {
        Task {
            do {
                let response = try await authService.authenticate()
                UserMemory.shared.token = response.token
                checkToken()
                createUserIfNeeded()
                presendHome()
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

}

