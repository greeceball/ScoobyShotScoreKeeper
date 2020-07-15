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
    var newPlayerName: String = ""
    var players: [String] = []
    
    @IBOutlet weak var playerSelectionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    @IBAction func addPlayerBottonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.presentAddPlayerAlert()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setUpViews() {
        playerSelectionTableView.dataSource = self
        playerSelectionTableView.delegate = self
    }
    func updateViews() {
        DispatchQueue.main.async {
            self.playerSelectionTableView.reloadData()
        }
    }
}

extension PlayerSelectionViewController: UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerSelectionTableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        let player = players[indexPath.row]
        
        cell.textLabel?.text = player
        
        return cell
    }
    
    func presentAddPlayerAlert(){
        let alert = UIAlertController(title: "Enter new players Name:", message: nil, preferredStyle: .alert)
        
        //alert.addTextField(configurationHandler: nil)
        
        alert.addTextField { (textField) in
            textField.delegate = self
            textField.placeholder = "Enter Player Name"
            textField.autocorrectionType = .default
            textField.autocapitalizationType = .words
            
        }
        
//        alert.addTextField { (textField) in
//            textField.delegate = self
//            textField.placeholder = "Enter new player's name here!"
//            textField.autocapitalizationType = .words
//            //textField.text = self.newPlayerName
//        }
        
        let addPlayerAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self.players.append(text)
            self.updateViews()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(addPlayerAction)
        alert.addAction(cancelAction)
        alert.view.layoutIfNeeded()
        
        self.present(alert, animated: true)
        self.view.setNeedsDisplay()
        
    }
}
