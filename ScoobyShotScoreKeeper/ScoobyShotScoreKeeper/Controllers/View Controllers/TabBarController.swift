//
//  TabBarViewController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 7/15/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    static let shared = TabBarController()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
