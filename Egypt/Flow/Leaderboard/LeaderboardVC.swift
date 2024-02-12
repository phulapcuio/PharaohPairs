//
//  LeaderboardVC.swift
//  Egypt
//
//  Created by apple on 07.02.2024.

import Foundation
import UIKit

class LeaderboardVC: UIViewController {
    
    private var leads = [ModelLead]()
    private let getLeadService = LeadService.shared
    private var contentView: LeaderBoardView {
        view as? LeaderBoardView ?? LeaderBoardView()
    }
    
    override func loadView() {
        view = LeaderBoardView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.leaderBoardTableView.dataSource = self
        contentView.leaderBoardTableView.delegate = self
        tappedButtons()
        loadUsers()
    }
    
    
    private func tappedButtons() {
        contentView.homeButtons.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func sorterScoreUsers() {
        leads.sort {
            $1.score < $0.score
        }
    }

    func loadUsers() {
        getLeadService.fetchData { [weak self] leads in
            guard let self = self else { return }
            self.leads = leads
            self.contentView.leaderBoardTableView.reloadData()
            self.sorterScoreUsers()
        } errorCompletion: { [weak self] error in
            guard self != nil else { return }
            
            }
        }
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
    
    func setupCell(leadCell: LeadCell, user: ModelLead) {
        
        leadCell.cointslabel.text = String(user.score)
        leadCell.userNameLabel.text = user.name == nil ? "USER# \(user.id ?? 0)" : user.name
        
    }
    
}



