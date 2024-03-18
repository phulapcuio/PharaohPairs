//
//  LeaderboardVC.swift
//  Egypt
//
//  Created by apple on 07.02.2024.

import Foundation
import UIKit

class LeaderboardVC: UIViewController {
    
    private var leads = [User]()
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
        UserApi.getUsers { result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async { [weak self] in
                    self?.leads = users.sorted(by: { $0.score > $1.score })
                    self?.contentView.leaderBoardTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
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
    
    func setupCell(leadCell: LeadCell, user: User) {
        
        leadCell.cointslabel.text = "\(user.score)"
        leadCell.userNameLabel.text = user.name == nil || user.name == "" ? "USER# \(String(user.id))" : user.name
    }
}



