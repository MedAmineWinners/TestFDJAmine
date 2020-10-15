//
//  ViewController.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    let searchBar = UISearchBar()
    
    private let homePresenter = HomePresenter(homeServices: HomeServices())
    
    var teams = [Team]()
    var leagues = [League]()
    override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter.setViewProtocol(homeViewProtocol: self)
        registerTableView()
        registerCollectionView()
        addSearchBar()
    }
    
    func showLeagues(leagues: [League]) {
        self.leagues = leagues
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showTeams(teams: [Team]) {
        self.teams = teams
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.collectionView.reloadDataAnimated()
        }
    }
    
    func showTeamsError(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - SearchBar extension
extension HomeViewController: UISearchBarDelegate {
    func addSearchBar() {
        searchBar.placeholder = "Search by league"
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        homePresenter.prepareLeaguesForSearch()
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homePresenter.getLeagues(with: searchBar.text!)
        tableView.isHidden = searchBar.text!.isEmpty
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let leagueName = searchBar.text {
            homePresenter.getTeams(for: leagueName)
            tableView.isHidden = true
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        searchBar.text = ""
    }
}

// MARK: - AutoComplete TableView extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func registerTableView() {
        tableView.register(UINib(nibName: "AutoCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: AutoCompleteTableViewCell.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCompleteTableViewCell") as! AutoCompleteTableViewCell
        cell.league = leagues[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden = true
        collectionView.isHidden = true
        searchBar.text = leagues[indexPath.row].strLeague
        homePresenter.getTeams(for: leagues[indexPath.row].strLeague ?? "")
        searchBar.resignFirstResponder()
    }
}

// MARK: - Teams Collection View extension
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func registerCollectionView() {
        collectionView.register(UINib.init(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCollectionViewCell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath as IndexPath) as! TeamCollectionViewCell
        cell.team = self.teams[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 50, height: (collectionView.bounds.width/2 - 50))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as!  DetailsViewController
        if let teamName = teams[indexPath.row].strTeam {
            teamDetailsVC.teamName = teamName
            self.navigationController?.pushViewController(teamDetailsVC, animated: true)
        }
    }
}
