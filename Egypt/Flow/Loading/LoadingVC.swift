//
//  LoadingVC.swift
//  Egypt
//

import Foundation
import UIKit

class LoadingVC: UIViewController {
    
    private var contentView: LoadingView {
        view as? LoadingView ?? LoadingView()
    }
    
    override func loadView() {
        view = LoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateProgressBar()
    }
    
    func animateProgressBar() {
        UIView.animate(withDuration: 3.5) {
            // Установите конечное значение прогресса
            self.contentView.loadView.setProgress(1.0, animated: true)
        }
    }

}

