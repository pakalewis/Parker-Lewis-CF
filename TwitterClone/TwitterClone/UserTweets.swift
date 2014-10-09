//
//  UserTweets.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/9/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class UserTweets: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var tweets : [Tweet]?
    var currentTweet : Tweet?
    var networkController : NetworkController!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make AppDelegate a singleton
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        
        self.tableview.registerNib(UINib(nibName: "CustomTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CustomCell")
        self.tableview.estimatedRowHeight = 75.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
        
        // download the user's tweets and store in userTweetsArray
        self.networkController.fetchTimeLine("user", userScreenName: currentTweet!.screen_name) { (errorDescription, tweets) -> (Void) in
            if errorDescription != nil {
                // there is a problem
            } else {
                self.tweets = tweets
                self.tableview.reloadData()
            }

        }
//        self.networkController.fetchUserTweets(currentTweet!.screen_name, completionHandler: { (errorDescription, tweets) -> (Void) in
//            if errorDescription != nil {
//                // there is a problem
//            } else {
//                self.tweets = tweets
//                self.tableview.reloadData()
//            }
//        })


        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : CustomTableViewCell = self.tableview.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as CustomTableViewCell
        
        // target the appropriate tweet
        let tweet = self.tweets?[indexPath.row]
        
        
        // set cell text to be the tweet text
        cell.cellText.text = tweet?.text
        
        // set tweet's image (if not yet downloaded, then call method on network controller
        if tweet?.profileImage != nil {
            cell.cellImage.image = tweet?.profileImage
        } else {
            cell.cellImage.image = tweet?.placeholderProfileImage
            self.networkController.downloadImage(tweet!, completionHandler: { (image) -> Void in
                cell.cellImage.image = image
            })
        }

        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
    }
}