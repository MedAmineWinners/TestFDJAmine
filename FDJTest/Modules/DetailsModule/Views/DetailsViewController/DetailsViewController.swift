//
//  DetailsViewController.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 06/10/2020.
//

import UIKit

// The team infos are already present in the previous call, but I called the API for this class to follow the instructions in the exercice.

class DetailsViewController: UIViewController, DetailsViewProtocol {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var coutryLabel: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var teamDescriptionLabel: UILabel!
    
    private let detailsPresenter = DetailsPresenter(detailsServices: DetailsServices())
    var teamName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPresenter.setViewProtocol(detailsViewProtocol: self)
        detailsPresenter.getTeam(with: teamName)
        navigationItem.title = teamName
    }
    
    func showTeamDetails(team: Team) {
        DispatchQueue.main.async {
            if let url = URL(string: team.strTeamBanner ?? "") {
                self.bannerImageView.load(url: url)
            }
            self.coutryLabel.text = team.strCountry
            self.leagueName.text = team.strLeague
            self.teamDescriptionLabel.text = team.strDescriptionEN
        }
    }
    
    func showTeamDetailsError(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
