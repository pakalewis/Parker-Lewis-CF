//
//  TweetViewController.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class TweetViewController: UIViewController {
    
    var tweet: Tweet?
    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var retweets: UILabel!
    @IBOutlet weak var favorited: UILabel!
    
    
    override func viewDidLoad() {
        self.tweetImage.image = self.tweet?.profileImage
        self.tweetText.text = self.tweet?.text
        self.username.text = self.tweet?.username
        self.retweets.text = "Retweets: \(self.tweet!.retweetCount)"
        self.favorited.text = "Favorited: \(self.tweet!.favoriteCount)"
    }
    
    @IBAction func dismissTweetViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
