//
//  WolfTeamSelectionBtnTableViewCell.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/13/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class WolfTeamSelectionBtnTableViewCell: UITableViewCell {

    //MARK: - Outlets and properties
    @IBOutlet weak var playerNameBtn: UIButton!
    var name: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        playerNameBtn.setTitle(name, for: .normal)
        // Configure the view for the selected state
    }

    class func createCell() -> WolfTeamSelectionBtnTableViewCell? {
        let nib = UINib(nibName: "WolfTeamSelectionBtnTableViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).last as? WolfTeamSelectionBtnTableViewCell
        return cell
    }
}
