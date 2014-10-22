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
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // check to see if OAuth token is saved in NSUserDefaults
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let tokenCheck = userDefaults.objectForKey("OauthToken") as? String {
            // token already stored
            println("Authorized token already saved: \(tokenCheck)")
            
            self.networkController.setupAuthenticatedSession()
        } else {
            // no token so fire the NetworkController that requests authorization

            // make alert controller
            var alert = self.networkController.makeAlertBeforeSafariOpens()
            self.presentViewController(alert, animated: true, completion: nil)
        }
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
        
        searchBar.resignFirstResponder()
        
        if self.networkController.authenticated {
            // returns true if authenticated so do the network call
            // this is the base github url for searching repositories
            var urlSearchString = "https://api.github.com/search/repositories?"
            // modify it with the search term(s) from the search bar
            urlSearchString = urlSearchString + "q=\(searchText)"
            println("urlSearchString: \(urlSearchString)")
            let url = NSURL(string: urlSearchString)
                        
            self.networkController.fetchJSONData(url!, completionHandler: { (errorDescription, rawJSONData) -> (Void) in
                
                if errorDescription != nil {
                    println("there was an error getting the JSON")
                } else {
                    // use the JSONData to fetch the array of repos
                    self.repoArray = self.networkController.parseJSONDataIntoArrayOfRepos(rawJSONData!)!
                    println("on repo VC, repo array count = \(self.repoArray.count)")
                    self.tableView.reloadData()
                }
            })
            
        } else {
            println("not authenticated. present alert")
            var alert = UIAlertController(title: "Alert", message: "Session is not yet authenticated", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
//                self.requestOAuthAccess()
                // figure out whether to do self.requestOAuthAccess or setupAuthenticatedSession()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(OKAction)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }

}
