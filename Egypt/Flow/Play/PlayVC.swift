//
//  PlayVC.swift
//  Egypt
//
//  Created by apple on 07.02.2024.
//

import Foundation
import UIKit

final class PlayVC: UIViewController {
    
    private var scoreCoints = UserMemory.shared.scoreCoints
    private var scoreLevel = UserMemory.shared.scoreLevel
    private var scoreMoves: Int = 0
    private var scoreLifes = UserMemory.shared.scoreLife
    private var buttonGridStackView: UIStackView!
    private var firstSelectedButton: UIButton?
    private var secondSelectedButton: UIButton?
    private var isInteractionEnabled = true
    private var buttons: [UIButton] = []
    private var pairedImages: [UIImage] = []
    private let egyptImagesOne: [String] = ["egypt1", "egypt2" ]
    private let egyptImagesSecond: [String] = ["egypt1", "egypt2", "egypt3", "egypt4" ]
    private let egyptImagesThree: [String] = ["egypt1", "egypt2", "egypt3", "egypt4", "egypt5", "egypt6"]
    private let egyptImagesThreeSecret: [String] = ["egypt1", "egypt2", "egypt3", "egypt4", "egypt5", "egypt6", "egypt10"]
    private let egyptImagesFour: [String] = ["egypt1", "egypt2", "egypt3", "egypt4", "egypt5", "egypt6", "egypt7", "egypt8" ]
    private let egyptImagesFive: [String] =  ["egypt1", "egypt2", "egypt3", "egypt4", "egypt5", "egypt6", "egypt7", "egypt8",
                                               "egypt9", "egypt10", "egypt11", "egypt12", "egypt13", "egypt14", "egypt15", "egypt16", "egypt17", "egypt18"]
    
    private var contentView: PlayView {
        view as? PlayView ?? PlayView()
    }
    
    override func loadView() {
        view = PlayView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadLevels()
    }
    
    private func setupLabel() {
        contentView.levelLabel.text = "Level \(scoreLevel)"
        contentView.levelLabel.font = .customFont(font: .montserrat, style: .black, size: 40)
        contentView.levelLabel.textColor = .gray
        contentView.lifesLabel.text = "\(scoreLifes)"
        contentView.lifesLabel.font = .customFont(font: .blackHanSans, style: .regular, size: 16)
        contentView.lifesLabel.textColor = .white
        contentView.movesLabel.text = "\(scoreMoves)"
        contentView.movesLabel.font = .customFont(font: .blackHanSans, style: .regular, size: 16)
        contentView.movesLabel.textColor = .white
        contentView.goldsLabel.text = "\(scoreCoints)"
        contentView.movesLabel.font = .customFont(font: .blackHanSans, style: .regular, size: 16)
        contentView.movesLabel.textColor = .white
    }
    
    private func reloadLevels() {
        scoreLevel = UserMemory.shared.scoreLevel
        contentView.goldsLabel.text = "\(UserMemory.shared.scoreCoints)"
        contentView.levelLabel.text = "Level \(UserMemory.shared.scoreLevel)"
        generatePairedImages(level: scoreLevel)
        createButtonGrid(inputImages: pairedImages)
    }
    
    private func tappedButtons() {
        contentView.homeButtons.addTarget(self, action: #selector(buttonTappedHome), for: .touchUpInside)
    }
    
    @objc func buttonTappedHome() {
        navigationController?.popViewController(animated: true)
    }
    
    private func data(input: [UIImage]) -> (Int, Int) {
        switch input.count {
        case 4: return (4, 1)
        case 8 : return(4, 2)
        case 12 : return(3, 4)
        case 14: return(7, 2)
        case 16: return(4, 4)
        case 36: return (6, 6)
        default: return (0, 0)
        }
    }
    
    private func generatePairedImages(level: Int) {
        var selectedImages: [String] = []
        
        switch level {
        case 1...2:
            selectedImages = egyptImagesOne
            scoreMoves = 2
        case 3...4:
            selectedImages = egyptImagesSecond
            scoreMoves = 4
        case 5...7:
            selectedImages = egyptImagesThree
            scoreMoves = 10
        case 8...9:
            selectedImages = egyptImagesThreeSecret
            scoreMoves = 10
        case 10...12:
            selectedImages = egyptImagesFour
            scoreMoves = 15
        case 13...25:
            selectedImages = egyptImagesFive
            scoreMoves = 20
        default:
            break
        }
        
        pairedImages = []
        pairedImages = selectedImages.compactMap { UIImage(named: $0) }
        pairedImages = pairedImages + pairedImages
        pairedImages.shuffle()
        contentView.movesLabel.text = "\(scoreMoves)"
        
    }
    
    private func createButtonGrid(inputImages: [UIImage]) {
        let buttonSize: CGFloat = 50
        let spacing: CGFloat = 10
        let (numberOfRows, numberOfColumns) = data(input: inputImages)
        
        buttonGridStackView = UIStackView()
        buttonGridStackView.axis = .vertical
        buttonGridStackView.alignment = .center
        buttonGridStackView.distribution = .fill
        buttonGridStackView.spacing = spacing
        buttons = []
        
        for row in 0..<numberOfRows {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .center
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = spacing
            
            for col in 0..<numberOfColumns {
                let button = UIButton()
                button.setBackgroundImage(.closeButtons, for: .normal)
                button.tag = (row * numberOfColumns) + col
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)
                }
                
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                
                rowStackView.addArrangedSubview(button)
                buttons.append(button)
            }
            
            buttonGridStackView.addArrangedSubview(rowStackView)
        }
        
        view.addSubview(buttonGridStackView)
        buttonGridStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(48)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard sender.alpha != 0, isInteractionEnabled else {
            return
        }
        
        if firstSelectedButton == nil {
            if scoreLifes == 0 {
                showGameOverAlert()
                buttonGridStackView.isHidden = true
            }
            firstSelectedButton = sender
        } else if secondSelectedButton == nil{
            if sender != firstSelectedButton  {
                secondSelectedButton = sender
            } else {
                return
            }
        }
        
        isInteractionEnabled = false
        
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            if let pairedImageIndex = self.pairedImageIndex(for: sender) {
                let pairedImage = self.pairedImages[pairedImageIndex]
                sender.setImage(pairedImage, for: .normal)
            }
        }, completion: { _ in
            if let button1 = self.firstSelectedButton, let button2 = self.secondSelectedButton {
                self.checkForMatch(button1, button2)
            } else {
                self.isInteractionEnabled = true
            }
        })
    }
    
    func showGameOverAlert() {
        let alertController = UIAlertController(title: "No lives",
                                                message: "Try your luck and replenish your lives in get bonus",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    private func pairedImageIndex(for button: UIButton) -> Int? {
        let pairedImageIndex = button.tag
        return (0..<pairedImages.count).contains(pairedImageIndex) ? pairedImageIndex : nil
    }
    
    private func checkForMatch(_ button1: UIButton, _ button2: UIButton) {
        if button1.currentImage == button2.currentImage {
            UIView.animate(withDuration: 0.5, animations: {
                button1.alpha = 0
                button2.alpha = 0
            }, completion: { _ in
                self.successHapticFeedback()
                self.clearSelectedButtons()
            })
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.transition(with: button1, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    button1.setImage(nil, for: .normal)
                }, completion: nil)
                
                UIView.transition(with: button2, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    button2.setImage(nil, for: .normal)
                }, completion: { _ in
                    self.failureHapticFeedback()
                    self.scoreMoves -= 1
                    self.contentView.movesLabel.text = "\(self.scoreMoves)"
                    self.clearSelectedButtons()
                })
            }
            
        }
    }
    
    private func successHapticFeedback() {
        guard UserMemory.shared.isOpen else { return }
        let failureFeedbackGenerator = UINotificationFeedbackGenerator()
        failureFeedbackGenerator.notificationOccurred(.success)
    }

    private func failureHapticFeedback() {
        guard UserMemory.shared.isOpen else { return }
        let failureFeedbackGenerator = UINotificationFeedbackGenerator()
        failureFeedbackGenerator.notificationOccurred(.error)
    }
    
    private func clearSelectedButtons() {
        firstSelectedButton = nil
        secondSelectedButton = nil
        self.isInteractionEnabled = true
        checkPlayGamming()
    }
    
    private func checkPlayGamming() {
        var isWin = true
        for button in buttons {
            if button.alpha != 0 {
                isWin = false
                break
            }
        }
        if isWin {
            showWinScreen()
        } else if scoreMoves == 0 {
            showLoseScreen()
        }
    }
    
    private  func showWinScreen() {
        let vc = CongratilationsVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func showLoseScreen() {
        scoreLifes -= 1
        UserMemory.shared.scoreLife = scoreLifes
        contentView.lifesLabel.text = "\(UserMemory.shared.scoreLife)"
        buttonGridStackView.isHidden = true
        let vc = GameOverVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
