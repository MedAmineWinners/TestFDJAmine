//
//  LeagueCollectionViewCell.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamLogoImgView: UIImageView!
    
    public var team: Team! {
        didSet {
            if let strTeamBadge = team.strTeamBadge {
                teamLogoImgView.load(url: URL(string: strTeamBadge)!)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
