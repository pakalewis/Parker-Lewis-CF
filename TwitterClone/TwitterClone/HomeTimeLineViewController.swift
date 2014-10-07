//
//  HomeTimeLineViewController.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/6/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import Accounts
import Social


class HomeTimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tweets : [Tweet]?
    var twitterAccount : ACAccount?
    let imageQueue = NSOperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
            if granted {
                let accounts = accountStore.accountsWithAccountType(accountType)
                self.twitterAccount = accounts.first as ACAccount?
                let url = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
                let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url, parameters: nil)
                twitterRequest.account = self.twitterAccount
                
                // this happens on an arbitrary thread
                twitterRequest.performRequestWithHandler({ (data, httpResponse, error) -> Void in
                    // first log out the status code
                    println(httpResponse.description)
                    
                    // switch statement to handle the various status code possibilities
                    switch httpResponse.statusCode {
                    case 200...299:
                        // download JSON from twitter and create tweets from the data
                        self.tweets = Tweet.parseJSONDataIntoTweets(data)
                        // this shifts back to the main thread
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.tableView.reloadData()
                        })
                    case 400...499:
                        println("client's fault")
                    case 500...599:
                        println("server's fault")
                    default:
                        println("unexpected result")
                    }
                })
            }
        }
    }

    
    
    
    //MARK:Tableview Stuff
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create new cell
        var cell : CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as CustomTableViewCell
        
        // target the appropriate tweet
        let tweet = self.tweets?[indexPath.row]
        
        // download the profile image on a new queue
        self.imageQueue.addOperationWithBlock { () -> Void in
            var imageData = NSData(contentsOfURL: tweet!.avatarUrl)
            var image = UIImage(data: imageData)
            
            // switch back to main queue to update the data for the custom cell
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                cell.cellImage.image = image
                cell.cellText.text = tweet?.text
                println(tweet?.text)
            })
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
    }
    


}
