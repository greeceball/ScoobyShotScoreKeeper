//
//  ScoreCardTableViewCell.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/23/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class ScoreCardTableViewCell: UITableViewCell {

    //MARK: - Outlet and properties
    var scoreCard: ScoreCard? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let scoreCard = scoreCard else { return }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
