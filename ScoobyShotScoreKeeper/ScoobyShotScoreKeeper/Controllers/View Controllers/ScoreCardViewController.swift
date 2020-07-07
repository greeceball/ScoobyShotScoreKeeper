//
//  FirstViewController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/8/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class ScoreCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK: - Outlets and Properties
    @IBOutlet weak var tableView: UITableView!
    var user: User?
    
    var previousScoreCards: [ScoreCard] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadUser()
        print(user)
    }
    @IBAction func shareBtnTapped(_ sender: Any) {
        shareUser()
    }
    
    @IBAction func newScoreCardBtnTapped(_ sender: Any) {
        
    }
    
    func shareUser() {
        guard let user = user else { return }
        if let userRef = user.appleUserRef{
            let userToShare = [userRef]
            let activityController = UIActivityViewController(activityItems: userToShare, applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    }
    func loadUser() {
       // guard let userID = UserDefaults.value(forKey: "userID") as? String else { return }
        
        
    }
    
    func setUpViews() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func loadData() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previousScoreCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCardCell", for: indexPath) as? ScoreCardTableViewCell
        let score = ScoreCardController.shared.scoreCards[indexPath.row]
        
        cell?.scoreCard = score
        
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNumOfHolesVC" {
            let destinationVC = segue.destination as? NumberOfHolesSelectionViewController
            
        }
    }
}

