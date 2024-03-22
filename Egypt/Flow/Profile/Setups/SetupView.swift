//
//  SetupView.swift
//  Egypt


import Foundation
import UIKit

class SetupView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backHome
        return imageView
    }()
    
    private(set) lazy var homeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.homeButtons, for: .normal)
        return button
    }()

    private(set) lazy var notView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private(set) lazy var notLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Enable notifications"
        label.font = .customFont(font: .montserrat, style: .medium, size: 16)
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var switchNotView: UISwitch = {
        let switchView = UISwitch()
        switchView.onTintColor = .customOrange
        switchView.thumbTintColor = .cyan
        switchView.layer.borderWidth = 2
        switchView.layer.borderColor = UIColor.customOrange.cgColor
        switchView.layer.cornerRadius = 16
        return switchView
    }()

    private(set) lazy var hatpicView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private(set) lazy var hatpicLabel: UILabel = {
        let label = UILabel()
        label.text = "Enable hatpic feedback"
        label.font = .customFont(font: .montserrat, style: .medium, size: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var switchHatpicView: UISwitch = {
        let switchView = UISwitch()
        switchView.onTintColor = .customOrange
        switchView.thumbTintColor = .cyan
        switchView.layer.borderWidth = 2
        switchView.layer.borderColor = UIColor.customOrange.cgColor
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [backImage,homeBtn,notView,hatpicView] .forEach(addSubview(_:))
        notView.addSubview(notLabel)
        notView.addSubview(switchNotView)
        hatpicView.addSubview(hatpicLabel)
        hatpicView.addSubview(switchHatpicView)
    }
    
    private func setupConstraints() {
        
        backImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeBtn.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.left.equalToSuperview().offset(24)
            make.size.equalTo(48)
        }

        notView.snp.makeConstraints { make in
            make.top.equalTo(homeBtn.snp.bottom).offset(80)
            make.height.equalTo(86)
            make.left.right.equalToSuperview().inset(24)
        }
        
        notLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        switchNotView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-16)
        }

        hatpicView.snp.makeConstraints { make in
            make.top.equalTo(notView.snp.bottom).offset(22)
            make.height.equalTo(86)
            make.left.right.equalToSuperview().inset(24)
        }
        
        hatpicLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        switchHatpicView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
