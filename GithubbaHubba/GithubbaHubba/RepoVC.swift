//
//  RepoVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class RepoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var repoArray = [Repo]()
    
    let networkController = NetworkController()
    
    override func viewWillAppear(animated: Bool) {
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        // this grabs the stored bool and prints it. just a check to see if I'm storing it correctly
        let firstLaunchBool = NSUserDefaults.standardUserDefaults().boolForKey("firstTimeLaunchingApp")
        println("firstTimeLaunchingApp bool: \(firstLaunchBool)")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        let url = NSURL(string: "http://localhost:3000")
        // replace this with a url from github
        // modify it to add the string captured from the search bar
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
}
