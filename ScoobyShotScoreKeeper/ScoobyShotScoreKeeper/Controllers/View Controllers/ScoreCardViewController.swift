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
  
    var previousScoreCards: [ScoreCard] = []
  override func viewDidLoad() {
      super.viewDidLoad()
      
  }
    @IBAction func newScoreCardBtnTapped(_ sender: Any) {
        
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

