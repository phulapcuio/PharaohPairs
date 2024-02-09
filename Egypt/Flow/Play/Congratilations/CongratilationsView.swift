//
//  CongratilationsView.swift
//  Egypt



import Foundation
import UIKit
import SnapKit

class CongratilationsView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backHome
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations!".uppercased()
        label.textAlignment = .center
        label.font = .customFont(font: .montserrat, style: .black, size: 24)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var centerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .con
        return imageView
    }()

    private(set) lazy var nextButtons: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(color:.customBrown), for: .normal)
        button.setBackgroundImage(UIImage(color: UIColor.customOrange), for: .highlighted)
        button.setTitle("next level".uppercased(), for: .normal)
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
        [backImage,titleLabel,centerImage,nextButtons] .forEach(addSubview(_:))
    }
    
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(centerImage.snp.top).offset(-100)
            make.centerX.equalToSuperview()
        }
        
        centerImage.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        nextButtons.snp.makeConstraints { (make) in
            make.top.equalTo(centerImage.snp.bottom).offset(80)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
    }
}
