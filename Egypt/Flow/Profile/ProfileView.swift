//
//  ProfileView.swift
//  Egypt
//

import Foundation
import UIKit

class ProfileView: UIView,UITextFieldDelegate {
    
    private lazy var backView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backHome
        return imageView
    }()
    
    private(set) lazy var homeButtons: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.homeButtons, for: .normal)
        return button
    }()
    
    private(set) lazy var infoButtons: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.infoButtons, for: .normal)
        return button
    }()

    private(set) lazy var setupButtons: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.setupButtons, for: .normal)
        return button
    }()

    private(set) lazy var profileBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.imageProfile, for: .normal)
        return button
    }()
    
    private lazy var profileTextField: UITextField = {
        let textField = UITextField()
        let placeholderText = NSAttributedString(string: "user#\(UserMemory.shared.userID ?? 1)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        
        textField.attributedPlaceholder = placeholderText
        if let savedUserName = UserMemory.shared.userID {
            textField.placeholder = "user#\(savedUserName)"
        }
        textField.font = UIFont.customFont(font: .montserrat, style: .black, size: 24)
        textField.textColor = .gray
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        textField.layer.cornerRadius = 30
        textField.textAlignment = .center
        textField.delegate = self
        textField.returnKeyType = .done
        textField.resignFirstResponder()
        return textField
    }()
    
    private lazy var bottomConImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bottomCon
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpConstraints()
        saveName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [backView,homeButtons,infoButtons,setupButtons,profileBtn,profileTextField,bottomConImage ] .forEach(addSubview(_:))
    }
    
    private func setUpConstraints(){
        
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        homeButtons.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.left.equalToSuperview().offset(24)
            make.size.equalTo(48)
        }
        
        setupButtons.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.right.equalToSuperview().offset(-24)
            make.size.equalTo(48)
        }
        
        infoButtons.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.right.equalTo(setupButtons.snp.left).offset(-16)
            make.size.equalTo(48)
        }
        
        profileBtn.snp.makeConstraints { (make) in
            make.top.equalTo(homeButtons.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(160)
        }
        
        profileTextField.snp.makeConstraints { (make) in
            make.top.equalTo(profileBtn.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(66)
        }
        
        bottomConImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    private func saveName() {
        if let savedUserName = UserMemory.shared.userName {
            profileTextField.text = savedUserName
        }
    }

    internal func textFieldDidEndEditing(_ textField: UITextField) {
        UserMemory.shared.userName = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Закрытие клавиатуры
        return true
    }
}
