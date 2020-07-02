//
//  PlayerSelectionViewController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 7/2/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class PlayerSelectionViewController: UIViewController {

    //MARK: - Outlets and Properties
    var numOfHoles: Int = 0
    @IBOutlet weak var playerSelectionTableView: UITableView!
    @IBOutlet weak var playerSelectionCell: UITableViewCell!
    @IBOutlet weak var nameOrNickNameLabel: UILabel!
    @IBOutlet weak var playerPDGANumberLabel: UILabel!
    @IBOutlet weak var numberOfRoundsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
