//
//  LeaderboardVC.swift
//  Egypt
//
//  Created by apple on 07.02.2024.

import Foundation
import UIKit

class LeaderboardVC: UIViewController {
    
    private var leads = [Datum]()
    private let getLeadService = LeadService.shared
    private var contentView: LeaderBoardView {
        view as? LeaderBoardView ?? LeaderBoardView()
    }
    
    override func loadView() {
        view = LeaderBoardView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeadTableVIew()
        tappedButtons()
        loadLeads()
    }
    
    
    private func setupLeadTableVIew() {
        contentView.leaderBoardTableView.dataSource = self
        contentView.leaderBoardTableView.delegate = self

    }
    
    private func tappedButtons() {
        contentView.homeButtons.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }

    func loadLeads() {
        getLeadService.fetchData { [weak self] leads in
            guard let self = self else { return }
            self.leads = leads.data
            self.contentView.leaderBoardTableView.reloadData()
        } errorCompletion: { [weak self] error in
            guard self != nil else { return }
            
            }
        }
    
//    func sorterScoreLeads() {
//        leads.sort {
//            $1.data[0].balance < $0.data[0].balance
//        }
//    }
}

extension LeaderboardVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeadCell.reuseId, for: indexPath)
        
        guard let leaderBoardCell = cell as? LeadCell else {
            
            return cell
        }
                
        let index = indexPath.row

        let lead = leads[index]
        
        setupCell(leadCell: leaderBoardCell, user: lead)
        
        return leaderBoardCell
    }
    
    func setupCell(leadCell: LeadCell, user: Datum) {
        
//        let data = user.data[0] // Извлекаем первый элемент массива data

        leadCell.cointslabel.text = "\(user.balance)"
        leadCell.userNameLabel.text = "USER# \(user.userID)"

    }
    
}



