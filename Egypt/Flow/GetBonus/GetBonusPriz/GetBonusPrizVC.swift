//
//  GetBonusPrizVC.swift
//  Egypt


import Foundation
import UIKit
import SnapKit

class GetBonusPrizVC: UIViewController {
    
    var total: Int = 0
    
    var contentView: GetBonusPrizView {
        view as? GetBonusPrizView ?? GetBonusPrizView()
    }
    
    override func loadView() {
        view = GetBonusPrizView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
        configureLabel()
    }
    
    private func tappedButtons() {
        contentView.homeButtons.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        contentView.thanksButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    private func configureLabel() {
        contentView.scoreLifeLabel.text = "+\(total)\n lifes"
    }

    @objc func closeView() {
        UserMemory.shared.lastBonusDate = Date()
        navigationController?.popToRootViewController(animated: true)
    }
}
