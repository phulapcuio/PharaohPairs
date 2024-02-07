//
//  HomeView.swift
//  Egypt

import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.backHome
        return imageView
    }()
    
    private lazy var topImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .topFly
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var bottomImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bottomFly
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var playButtons: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customBrown
        button.setTitle("Play".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.customFont(font: .montserrat, style: .medium, size: 20)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.customOrange.cgColor
        return button
    }()
    
    private(set) lazy var getBonusButtons: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customBrown
        button.setTitle("Get Bonus".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.customFont(font: .montserrat, style: .medium, size: 20)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.customOrange.cgColor
        return button
    }()
    
    private(set) lazy var leadButtons: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customBrown
        button.setTitle("leaderboard".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.customFont(font: .montserrat, style: .medium, size: 20)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.customOrange.cgColor
        return button
    }()

    private(set) lazy var profileButtons: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.profileButtons, for: .normal)
        return button
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [backImage,profileButtons,topImage,bottomImage,playButtons,getBonusButtons,leadButtons] .forEach(addSubview(_:))
    }
    
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        profileButtons.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-24)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
        }

        topImage.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(profileButtons.snp.bottom).offset(74)
        }

        playButtons.snp.makeConstraints { (make) in
            make.top.equalTo(topImage.snp.bottom).offset(74)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(280)
        }
        
        getBonusButtons.snp.makeConstraints { (make) in
            make.top.equalTo(playButtons.snp.bottom).offset(74)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(280)
        }
        
        leadButtons.snp.makeConstraints { (make) in
            make.top.equalTo(getBonusButtons.snp.bottom).offset(74)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(280)

        }

        bottomImage.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(leadButtons.snp.bottom).offset(74)
        }
    }
}
