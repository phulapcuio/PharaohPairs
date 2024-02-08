//
//  SetupVC.swift
//  Egypt
//
import Foundation
import UIKit

class SetupVC: UIViewController {
    
    private var contentView: SetupView {
        view as? SetupView ?? SetupView()
    }
    
    override func loadView() {
        view = SetupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    private func tappedButtons() {
        contentView.switchHatpicView.setOn(UserMemory.shared.isOpen, animated: false)
        contentView.homeBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        contentView.switchNotView.addTarget(self, action: #selector(switchNotValueChanged(_:)), for: .valueChanged)
        contentView.switchHatpicView.addTarget(self, action: #selector(switchHatpicValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func buttonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func switchNotValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            contentView.switchNotView.layer.borderColor = UIColor.white.cgColor
            print("on")

        } else {
            contentView.switchNotView.layer.borderColor = UIColor.customOrange.cgColor
            print("off")
        }
    }
    
    @objc private func switchHatpicValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            contentView.switchHatpicView.layer.borderColor = UIColor.white.cgColor
            print("on")

        } else {
            contentView.switchHatpicView.layer.borderColor = UIColor.customOrange.cgColor
            print("off")
        }
    }
}
