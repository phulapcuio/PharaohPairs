//
//  GameOverVC.swift
//  Egypt


import Foundation
import UIKit

class GameOverVC: UIViewController {
    
    private var contentView: GameOverView {
        view as? GameOverView ?? GameOverView()
    }
    
    override func loadView() {
        view = GameOverView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
        contentView.tryButtons.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.contentView.tryButtons.layer.borderColor = UIColor.customOrange.cgColor
           }
        dismiss(animated: true)
    }
}

