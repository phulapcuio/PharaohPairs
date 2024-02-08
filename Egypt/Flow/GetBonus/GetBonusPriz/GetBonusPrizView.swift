//
//  GetBonusPrizView.swift
//  Egypt


import UIKit
import SnapKit

class GetBonusPrizView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backHome
        return imageView
    }()
    
    private(set) lazy var homeButtons: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.homeButtons, for: .normal)
        return button
    }()

    private lazy var winLabel: UILabel = {
        let label = UILabel()
        label.text = "bonus".uppercased()
        label.textAlignment = .center
        label.font = .customFont(font: .montserrat, style: .black, size: 40)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var lifeUpImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .life
        return imageView
    }()
    
    private(set) lazy var scoreLifeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .customFont(font: .montserrat, style: .black, size: 40)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var thanksButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(color:.customBrown), for: .normal)
        button.setBackgroundImage(UIImage(color: UIColor.customOrange), for: .highlighted)
        button.setTitle("Thanks".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.customFont(font: .montserrat, style: .medium, size: 20)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.customOrange.cgColor
        button.clipsToBounds = true
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
        [backImage,homeButtons,winLabel,scoreLifeLabel,lifeUpImage,thanksButton] .forEach(addSubview(_:))
    }
    
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        homeButtons.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.left.equalToSuperview().offset(24)
            make.size.equalTo(48)
        }
        
        winLabel.snp.makeConstraints { (make) in
            make.top.equalTo(homeButtons.snp.top).offset(60)
            make.centerX.equalToSuperview()
        }
        
        scoreLifeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(winLabel.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
        
        lifeUpImage.snp.makeConstraints { (make) in
            make.top.equalTo(scoreLifeLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        thanksButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-52)
        }
    }
}
