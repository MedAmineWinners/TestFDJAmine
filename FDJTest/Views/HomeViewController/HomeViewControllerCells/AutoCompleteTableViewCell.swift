//
//  AutoCompleteTableViewCell.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import UIKit

class AutoCompleteTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
   
    public var league: League! {
        didSet {
            leagueName.text = league.strLeague
        }
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
