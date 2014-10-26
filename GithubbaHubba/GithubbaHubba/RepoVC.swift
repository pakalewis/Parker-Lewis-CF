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
    var selectedRepo = Repo()
    var defaultImage = UIImage(named: "default")

    
    
    override func viewWillAppear(animated: Bool) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !NetworkController.controller.authenticated {
            // check to see if OAuth token is saved in NSUserDefaults
            let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if let tokenCheck = userDefaults.objectForKey("OauthToken") as? String {
                // token already stored
                println("Authorized token already saved: \(tokenCheck)")
                
                NetworkController.controller.setupAuthenticatedSession()
            } else {
                // no token so fire the NetworkController that requests authorization
                
                // make alert controller
                var alert = NetworkController.controller.makeAlertBeforeSafariOpens()
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            println("ALREADY AUTHENTICATED")
        }
    }
    

    
    
    
    
    // MARK: Table View methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL", forIndexPath: indexPath) as RepoCell
        

        self.selectedRepo = self.repoArray[indexPath.row]
        cell.nameLabel.text = self.selectedRepo.name
        cell.urlLabel.text = self.selectedRepo.url
        cell.repoAvatarImageView.image = self.defaultImage
        
        
        let currentCellTag = cell.tag + 1
        cell.tag = currentCellTag
        
        
        // if the avatar has already been downloaded, show it in the cell's image
        if self.selectedRepo.avatarImage != nil {
            println("ALREADY DOWNLOADED repo avatar at indexPath \(indexPath.row)")
            if currentCellTag == cell.tag {
                cell.repoAvatarImageView.image = self.selectedRepo.avatarImage
            }
        } else {
            // repo image is not available yet
            println("NOT DOWNLOADED display default image first, then download actual avatar")
            
            // download avatar, provided the cell is still visible
            NetworkController.controller.downloadImage(self.selectedRepo.avatarURL, completionHandler: { (image) -> Void in
                if currentCellTag == cell.tag {
                    self.selectedRepo.avatarImage = image
                    cell.repoAvatarImageView.image = self.selectedRepo.avatarImage
                }
            })
        }

        
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoArray.count
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("row: \(indexPath.row)")

        // initialize next view controller
        var destinationVC = storyboard?.instantiateViewControllerWithIdentifier("WEB_VC") as WebVC
        
        // Set currentUser and reverseOrigin properties on next view controller
        self.selectedRepo = self.repoArray[indexPath.row]
        var repoURLString = selectedRepo.url
        destinationVC.initialURLString = repoURLString
        
        self.navigationController?.pushViewController(destinationVC, animated: true)

    }
    
    
    
    //MARK: Search Bar methods
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println(searchText)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text
        println("user wants to search for: \(searchText)")
        
        searchBar.resignFirstResponder()
        
        if NetworkController.controller.authenticated {
            // returns true if authenticated so do the network call
            // this is the base github url for searching repositories
            var urlSearchString = "https://api.github.com/search/repositories?per_page=90&"
            // modify it with the search term(s) from the search bar
            urlSearchString = urlSearchString + "q=\(searchText)"
            println("urlSearchString: \(urlSearchString)")
            let url = NSURL(string: urlSearchString)
                        
            NetworkController.controller.fetchJSONData(url!, completionHandler: { (errorDescription, rawJSONData) -> (Void) in
                
                if errorDescription != nil {
                    println("there was an error getting the JSON")
                } else {
                    // use the JSONData to fetch the array of repos
                    self.repoArray = NetworkController.controller.parseJSONDataForRepos(rawJSONData!)!
                    self.tableView.reloadData()
                }
            })
            
        } else {
            println("not authenticated. present alert")
            var alert = UIAlertController(title: "Session is not authenticated", message: "Tap OK to authenticate", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                var alert = NetworkController.controller.makeAlertBeforeSafariOpens()
                self.presentViewController(alert, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(OKAction)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {

        // ERROR - delete key not recognized
        if text == "" {
            println("delete pressed")
            // not quite correct since this gets cut/paste
        }
        
        return text.validateStringWithoutSpecialCharacters()
    }


}
