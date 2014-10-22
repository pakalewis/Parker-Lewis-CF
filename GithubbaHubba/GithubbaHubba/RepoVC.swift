//
//  RepoVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class RepoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var repoArray = [Repo]()
    
    var networkController : NetworkController!
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // grab reference to singular NetworkController from AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.globalNetworkController

    }
    
    
    
    
    // MARK: Table View methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as RepoCell
        let repo = self.repoArray[indexPath.row]
        cell.nameLabel.text = repo.name
        cell.urlLabel.text = repo.url
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoArray.count
    }

    
    
    
    
    //MARK: Search Bar methods
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println(searchText)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text
        println("user wants to search for: \(searchText)")
        
        // this is the base github url for searching repositories
        var urlSearchString = "https://api.github.com/search/repositories?"
        // modify it with the search term(s) from the search bar
        urlSearchString = urlSearchString + "q=\(searchText)"
        println("urlSearchString: \(urlSearchString)")
        let url = NSURL(string: urlSearchString)
        
        
        // move this to the func that fires when user hits enter on search bar
        self.networkController.getDataAndReturnJSON(url!, completionHandler: { (errorDescription, repos) -> (Void) in
            if errorDescription != nil {
                println("there was an error getting the JSON")
            } else {
                self.repoArray = repos!
                println("on repo VC, repo array count = \(self.repoArray.count)")
                self.tableView.reloadData()
            }
        })

    }

}
