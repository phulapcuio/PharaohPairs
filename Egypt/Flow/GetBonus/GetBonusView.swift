//
//  GetBonusView.swift
//  Egypt
//

import Foundation
import UIKit
import SnapKit

class GetBonusView: UIView {
    
    let segmentValues = [3, 5, 10, 2, 7, 15, 5, 1]
    private  var corners: [CircleView] = []
    private  let count = 8
    private let colors: [UIColor] = [.clear, .clear, .clear, .clear, .clear, .clear, .clear, .clear]

    
    private(set)  var dailyBonusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backImageBonus: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backHome
        return imageView
    }()

    private(set) lazy var homeButtonsTimer: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.homeButtons, for: .normal)
        return button
    }()
    
    private(set) lazy var homeButtonsDayli: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.homeButtons, for: .normal)
        return button
    }()
    
    private(set) lazy var selectImageView: UIImageView = {
        let image = UIImageView()
        image.image = .arrow
        return image
    }()
    
    private(set) lazy var wheelContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    private(set) lazy var wheelImage: UIImageView = {
        let image = UIImageView()
        image.image = .wheel
        return image
    }()
    
    private(set) lazy var goButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(color:.customBrown), for: .normal)
        button.setBackgroundImage(UIImage(color: UIColor.customOrange), for: .highlighted)
        button.setTitle("get bonus".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.customFont(font: .montserrat, style: .medium, size: 20)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.customOrange.cgColor
        button.clipsToBounds = true
        return button
    }()
    
    private(set)  var timerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private lazy var backImageTimer: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .backHome
        return imageView
    }()
    
    private(set)  var titleTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time to next bonus:"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.customFont(font: .montserrat, style: .medium, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var timecountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.customFont(font: .montserrat, style: .black, size: 40)
        return label
    }()
    
    private lazy var bottomFlyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bottomFly
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    private(set) lazy var okBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(color:.customBrown), for: .normal)
        button.setBackgroundImage(UIImage(color: UIColor.customOrange), for: .highlighted)
        button.setTitle("ok".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.customFont(font: .montserrat, style: .medium, size: 20)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.customOrange.cgColor
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCircle()
        setupUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(dailyBonusView)
        dailyBonusView.addSubview(backImageBonus)
        dailyBonusView.addSubview(goButton)
        dailyBonusView.addSubview(wheelContainer)
        wheelContainer.addSubview(wheelImage)
        dailyBonusView.addSubview(homeButtonsDayli)
        dailyBonusView.addSubview(selectImageView)
        addSubview(timerView)
        timerView.addSubview(backImageTimer)
        timerView.addSubview(homeButtonsTimer)
        timerView.addSubview(titleTimeLabel)
        timerView.addSubview(timecountLabel)
        timerView.addSubview(bottomFlyImage)
        timerView.addSubview(okBtn)
        
    }
    
    private func setUpConstraints(){
        
        dailyBonusView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backImageBonus.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        homeButtonsDayli.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.left.equalToSuperview().offset(24)
            make.size.equalTo(48)
        }
   
        wheelContainer.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        wheelImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        selectImageView.snp.makeConstraints { (make) in
            make.top.equalTo(wheelContainer.snp.top).offset(-28)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        goButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-46)
        }
        
        timerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backImageTimer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeButtonsTimer.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(34)
            make.left.equalToSuperview().offset(24)
            make.size.equalTo(48)
        }

        titleTimeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(homeButtonsTimer.snp.bottom).offset(80)
        }
        
        timecountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleTimeLabel.snp.bottom).offset(20)
            make.height.equalTo(32)
        }
        
        bottomFlyImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timecountLabel.snp.bottom).offset(72)
        }
        
        okBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-52)
        }
    }
    
    private func setupCircle() {
        for index in 0..<count {
            let corner = CircleView(startAngle: CGFloat(Double(index) / Double(count) * 2 * Double.pi),
                                 endAngle: CGFloat(Double(index + 1) / Double(count) * 2 * Double.pi),
                                 color: colors[index % colors.count])
            wheelContainer.addSubview(corner)
            corners.append(corner)
        }
        corners.forEach { corner in
            corner.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
        }
    }
}
