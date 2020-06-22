//
//  NumberOfHolesSelectionViewController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/22/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class NumberOfHolesSelectionViewController: UIViewController {

    @IBOutlet weak var numberOfHolesPickerView: UIPickerView!
    
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

extension NumberOfHolesSelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NumberOfHoles.holes.count
    }
    
    
}
