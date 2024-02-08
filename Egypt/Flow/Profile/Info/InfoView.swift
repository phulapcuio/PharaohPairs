//
//  InfoView.swift
//  Egypt

import Foundation
import UIKit
import SnapKit

class InfoView: UIView {
    
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

    private(set) lazy var imageConteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.65).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .init(width: 0, height: 8)
        view.layer.shadowRadius = 14
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.customOrange.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private (set) var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Settings.appTitle)"
        label.textAlignment = .center
        label.font = .customFont(font: .montserrat, style: .black, size: 40)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
                label.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
        label.textColor = .white
        label.font = .customFont(font: .montserrat, style: .medium, size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var infoConteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 32
        return view
    }()
    
    private(set) lazy var infoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return scrollView
    }()
    
    private lazy var bottomConImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bottomCon
        return imageView
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
        [backView,infoScrollView,homeBtn] .forEach(addSubview(_:))
        infoScrollView.addSubview(infoConteinerView)
        infoConteinerView.addSubview(imageConteinerView)
        infoConteinerView.addSubview(subTitleLabel)
        infoConteinerView.addSubview(contentLabel)
        imageConteinerView.addSubview(iconImage)
        infoConteinerView.addSubview(bottomConImage)
    }
    
    private func setupConstraints() {
     
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(56)
            make.size.equalTo(40)
        }
        
        infoScrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-24)
        }
        
        infoConteinerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageConteinerView.snp.makeConstraints { make in
            make.top.equalTo(homeBtn.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(180)
        }
        
        iconImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
        }
        
        bottomConImage.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.left.right.equalToSuperview()
        }

    }
}
