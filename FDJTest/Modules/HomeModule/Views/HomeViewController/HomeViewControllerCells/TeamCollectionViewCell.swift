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
            if let url = URL(string: team.strTeamBadge ?? "")  {
                teamLogoImgView.load(url: url)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        teamLogoImgView.image = nil
    }
}
