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
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var retweets: UILabel!
    @IBOutlet weak var favorited: UILabel!

    var tweet: Tweet?
    var userTweetsArray : [Tweet]?
    var networkController : NetworkController!

    
    
    override func viewDidLoad() {
        // make AppDelegate a singleton
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        

        // populate items with the data from the Tweet property
        // why must I make the tempImage var?? it was giving me unwrapping error
        var tempImage = self.tweet?.profileImage
        var resizedImage = resizeImage(tempImage!, size: self.imageButton.frame.width)
        self.imageButton.setImage(resizedImage, forState: .Normal)
        self.imageButton.layer.cornerRadius = self.imageButton.frame.size.width / 2

        // WHY DO I NEED TO ADD THE .CGColor???
        self.imageButton.layer.borderWidth = 2.0
        self.imageButton.layer.borderColor = UIColor.blackColor().CGColor
        self.imageButton.clipsToBounds = true

        
        self.tweetText.text = self.tweet?.text
        self.username.text = self.tweet?.username
        self.retweets.text = "Retweets: \(self.tweet!.retweetCount)"
        self.favorited.text = "Favorited: \(self.tweet!.favoriteCount)"
    }

    
    // func to resize an image
    func resizeImage(image:UIImage, size:CGFloat) -> UIImage {
        var newSize:CGSize = CGSize(width: size, height: size)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    @IBAction func imageButtonPressed(sender: AnyObject) {
        // create the new viewcontroller
        var userTweetsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UserTweets") as UserTweets
        // pass the info from this user's tweet
        userTweetsViewController.currentTweet = self.tweet
        // push the new VC
        self.navigationController?.pushViewController(userTweetsViewController, animated: true)
    }
}
