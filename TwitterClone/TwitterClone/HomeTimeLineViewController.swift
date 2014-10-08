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
    var currentTweet : Tweet?
    var twitterAccount : ACAccount?
    let imageQueue = NSOperationQueue()
    var networkController : NetworkController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // make AppDelegate a singleton
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        // talk to network controller and call it's method to fetch tweets
        self.networkController.fetchHomeTimeLine { (errorDescription, tweets) -> (Void) in
            if errorDescription != nil {
                // there is a problem
            } else {
                self.tweets = tweets
                self.tableView.reloadData()
            }
        }
        
    }

    
    
    
    //MARK:Tableview Stuff
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create new cell
        var cell : CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as CustomTableViewCell
        
        // target the appropriate tweet
        let tweet = self.tweets?[indexPath.row]
        
        self.imageQueue.addOperationWithBlock { () -> Void in
            let image = self.networkController.downloadImage(tweet!.avatarUrl)
            
            // save the image to the Tweet obj
            self.tweets?[indexPath.row].profileImage = image
            
            // switch back to main queue to update the data for the custom cell
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                cell.cellImage.image = image
                cell.cellText.text = tweet?.text
                println(tweet?.text)
            })
        }
        return cell
    }
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var newTweetViewController = segue.destinationViewController as TweetViewController
        if segue.identifier == "ShowTweet" {
            var indexPath = self.tableView.indexPathForSelectedRow()
            self.currentTweet = self.tweets?[indexPath!.row]
        }
        newTweetViewController.tweet = self.currentTweet
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
