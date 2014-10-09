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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.tableview.registerNib(UINib(nibName: "CustomTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CustomCell")
        self.tableview.estimatedRowHeight = 75.0
        self.tableview.rowHeight = UITableViewAutomaticDimension

        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : CustomTableViewCell = self.tableview.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as CustomTableViewCell
        
        // target the appropriate tweet
        let tweet = self.tweets?[indexPath.row]
        
        // IF TWEET ALEADY HAS IMAGE, DON'T DL AGAIN
        // MOVE THIS IMAGE QUEUE TO NETWORK CONTROLLER
//        self.imageQueue.addOperationWithBlock { () -> Void in
//            let image = self.networkController.downloadImage(tweet!.avatarUrl)
//            
//            // save the image to the Tweet obj
//            self.tweets?[indexPath.row].profileImage = image
//            
//            // switch back to main queue to update the data for the custom cell
//            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                cell.cellImage.image = image
//                cell.cellText.text = tweet?.text
//                println(tweet?.text)
//            })
//        }
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