//
//  LeaderBoardView.swift


import Foundation
import UIKit

class LeaderBoardView: UIView {
    
    private lazy var backImage: UIImageView = {
        let im = UIImageView()
        im.image = .backHome
        return im
    }()

    private(set) lazy var homeButtons: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.homeButtons, for: .normal)
        return button
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Leaders"
        label.textAlignment = .center
        label.font = .customFont(font: .montserrat, style: .black, size: 24)
        label.textColor = .yellow
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var leaderBoardTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LeadCell.self, forCellReuseIdentifier: LeadCell.reuseId)
        tableView.separatorStyle = .none
        return tableView
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
        [backImage,homeButtons,titleLabel,leaderBoardTableView] .forEach(addSubview(_:))
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
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(homeButtons.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        leaderBoardTableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-48)
        }
    }
}
