//
//  NumberOfHolesSelectionViewController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/22/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class NumberOfHolesSelectionViewController: UIViewController {

    //MARK: - Outlets and properties
    @IBOutlet weak var numberOfHolesPickerView: UIPickerView!
    
    var pickerData: [Int] = []
    var numOfHoles: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPickerData()
        numberOfHolesPickerView.delegate = self
        numberOfHolesPickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(numOfHoles)
        if segue.identifier == "toPlayerSelection" {
            let destinationVC = segue.destination as? PlayerSelectionViewController
            destinationVC?.numOfHoles = numOfHoles
        }
    }
    
    func loadPickerData() {
        pickerData = NumberOfHoles.holes
    }
}

extension NumberOfHolesSelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NumberOfHoles.holes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerRow = pickerData[row].description
        return pickerRow
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numOfHoles = pickerData[row]
    }
    
}
