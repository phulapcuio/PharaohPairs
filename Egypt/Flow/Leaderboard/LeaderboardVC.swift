//
//  LeaderboardVC.swift
//  Egypt
//
//  Created by apple on 07.02.2024.

import Foundation
import UIKit

class LeaderboardVC: UIViewController {
    
    private var contentView: LeaderboardView {
        view as? LeaderboardView ?? LeaderboardView()
    }
    
    override func loadView() {
        view = LeaderboardView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    
    private func tappedButtons() {
        contentView.homeBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}

