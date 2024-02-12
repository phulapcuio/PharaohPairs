//
//  LeadCell.swift
//  Egypt

import Foundation
import UIKit
import SnapKit

class LeadCell: UITableViewCell {
    
    static let reuseId = String(describing: LeadCell.self)
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backHome
        return imageView
    }()
    
    
    private(set) lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(font: .montserrat, style: .medium, size: 20)
        label.textColor = .white
        return label
    }()

    private(set) lazy var cointslabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(font: .blackHanSans, style: .regular, size: 20)
        label.textColor = .yellow
        return label
    }()
    
    private(set) lazy var leadView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setUpConstraints()
    }
    
        func setupUI() {
            contentView.addSubview(leadView)
            contentView.backgroundColor = .clear
            contentView.layer.cornerRadius = 8
            
            [backImage,cointslabel,userNameLabel] .forEach(leadView.addSubview(_:))

        }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userNameLabel.text = nil
        cointslabel.text =  nil
    }
    
    private func setUpConstraints(){
        
        leadView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview()
            make.size.equalTo(150)
        }

        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        cointslabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-4)
            make.left.equalToSuperview().offset(32)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview().offset(-4)
        }
    }
}
