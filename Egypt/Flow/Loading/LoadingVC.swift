//
//  LoadingVC.swift
//  Egypt
//

import Foundation
import UIKit

class LoadingVC: UIViewController {
    
    private let authService = AuthTokenService.shared
    private let postService = PostService.shared
    
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
                try await authService.authenticate()
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
            let payload = CreateRequestPayload(name: nil, score: 0)
            postService.createUser(payload: payload) { [weak self] createResponse in
                guard let self = self else { return }
                UserMemory.shared.userID = createResponse.id
            } errorCompletion: { error in
                print("Ошибка получени данных с бека")
            }
        }
    }

}

