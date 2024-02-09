//
//  LeaderboardView.swift
//  Egypt

import Foundation
import UIKit
import SnapKit

class LeaderboardView: UIView {
    
    private lazy var backView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.backHome
        return imageView
    }()

    private(set) lazy var homeBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage.homeButtons, for: .normal)
        return button
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
        [backView,homeBtn] .forEach(addSubview(_:))
  
    }
    
    private func setupConstraints() {
     
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.left.equalToSuperview().offset(24)
            make.size.equalTo(48)
        }
    }
}
