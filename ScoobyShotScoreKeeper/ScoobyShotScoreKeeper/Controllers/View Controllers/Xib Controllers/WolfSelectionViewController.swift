//
//  WolfSelectionViewController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/13/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import Foundation
import UIKit

class WolfSelectionViewController: UIViewController {

    //MARK: - Outlets and Properties
    @IBOutlet weak var playerNameTextLabel: UILabel!
    @IBOutlet weak var playerSelectionTableView: UITableView!
    var players: [String?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView(){
        playerSelectionTableView.dataSource = self
        playerSelectionTableView.delegate = self
        let nib = UINib.init(nibName: "WolfTeamSelectionBtnTableViewCell", bundle: nil)
        self.playerSelectionTableView.register(nib, forCellReuseIdentifier: "WolfSelectionBtnCell")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WolfSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WolfSelectionBtnCell", for: indexPath) as! WolfTeamSelectionBtnTableViewCell
        
        cell.playerNameBtn.setTitle(players[indexPath.row], for: .normal)
        
        return cell
    }
    
    
}
