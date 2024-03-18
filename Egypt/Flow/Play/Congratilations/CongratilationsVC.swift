//
//  CongratilationsVC.swift
//  Egypt
//



import Foundation
import UIKit

class CongratilationsVC: UIViewController {
    
    private let postService = PostRequestService.shared
    
    private var contentView: CongratilationsView {
        view as? CongratilationsView ?? CongratilationsView()
    }
    
    override func loadView() {
        view = CongratilationsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
        contentView.nextButtons.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.contentView.nextButtons.layer.borderColor = UIColor.customOrange.cgColor
           }
        UserMemory.shared.scoreCoints += 10
        UserMemory.shared.scoreLevel += 1
        updateScore()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.dismiss(animated: true)
        }
    }
    
    private func updateScore() {
        guard let id = UserMemory.shared.userID else { return }
        UserApi.updateData(payload: UpdateUserPayload(id: id, name: UserMemory.shared.userName, score: nil)) { result in
            switch result {
            case .success(let data):
                print("Result: \(data.score)")
            case .failure(let error):
                print("Failuer: \(error.localizedDescription)")
            }
        }
    }
}
