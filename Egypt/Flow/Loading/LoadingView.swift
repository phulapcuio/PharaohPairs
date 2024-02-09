//
//  LoadingView.swift
//  Egypt
//
import Foundation
import UIKit
import SnapKit

class LoadingView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.backHome
        return imageView
    }()

    private (set) var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reveal the secrets\n\(Settings.appTitle)"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .customOrange
        return label
    }()

    
    private (set) var egyptImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imageEgypt
        imageView.contentMode = .scaleToFill
        return imageView
    }()
        
    private lazy var loadLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading...".uppercased()
        label.font = UIFont.customFont(font: .montserrat, style: .black, size: 24)
        label.textColor = .customOrange
        label.textAlignment = .center
        return label
    }()
 
    private(set) lazy var loadView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progress = 0.0
        progressView.progressTintColor = .customOrange
        return progressView
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
        [backImage,egyptImage,titleLabel,loadLabel,loadView] .forEach(addSubview(_:))
   
    }
    
    private func setupConstraints() {
     
        backImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        egyptImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(60)
        }
        
        loadLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(egyptImage.snp.bottom).offset(60)
        }
        
        loadView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loadLabel.snp.bottom).offset(24)
            make.width.equalTo(126)

        }

    }
}
