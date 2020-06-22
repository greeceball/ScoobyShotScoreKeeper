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
  
  override func viewDidLoad() {
      super.viewDidLoad()
      
  }
  
  func setUpViews() {
      tableView.dataSource = self
      tableView.delegate = self
      
  }
    @objc func loadData() {
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    


}

