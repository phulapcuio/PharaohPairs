//
//  PlayView.swift
//  Egypt

import Foundation
import UIKit
import SnapKit

class PlayView: UIView {

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

    private(set) lazy var goldsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imageGolds
        return imageView
    }()
    
    private(set) lazy var goldsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.customFont(font: .blackHanSans, style: .regular, size: 16)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var lifesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imageLifes
        return imageView
    }()
    
    private(set) lazy var lifesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.customFont(font: .blackHanSans, style: .regular, size: 16)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var movesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imageMoves
        return imageView
    }()
    
    private(set) lazy var movesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.customFont(font: .blackHanSans, style: .regular, size: 16)
        return label
    }()
    
    private(set) lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.customFont(font: .montserrat, style: .black, size: 40)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [backImage,homeButtons,lifesImageView,lifesLabel,goldsImageView,goldsImageView,goldsLabel,movesImageView,movesLabel,levelLabel] .forEach(addSubview(_:))
    }
    
    func setupConstraints() {
        
        backImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeButtons.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(34)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(50)
        }
        
        movesImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(34)
            make.left.equalTo(homeButtons.snp.right).offset(12)
        }
        
        movesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(movesImageView).offset(-4)
            make.right.equalTo(movesImageView.snp.right).offset(-16)
        }
        
        lifesImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(34)
            make.left.equalTo(movesImageView.snp.right).offset(12)
        }
        
        lifesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lifesImageView).offset(-2)
            make.right.equalTo(lifesImageView.snp.right).offset(-16)
        }
        
        goldsImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(34)
            make.left.equalTo(lifesImageView.snp.right).offset(8)
        }

        goldsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(goldsImageView).offset(-2)
            make.right.equalTo(goldsImageView.snp.right).offset(-12)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(goldsImageView.snp.bottom).offset(64)
            make.centerX.equalToSuperview()
        }
    }
}
