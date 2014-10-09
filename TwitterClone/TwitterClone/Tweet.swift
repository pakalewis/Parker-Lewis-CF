//
//  Tweet.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/6/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class Tweet {
    
    var text : String
    var username : String
    var avatarUrl : NSURL
    var profileImage = UIImage(named: "default")
    var retweetCount : String
    var favoriteCount : String
    
    
    
    init (tweetInfo : NSDictionary) {
        let userDictionary = tweetInfo["user"] as NSDictionary
        self.text = tweetInfo["text"] as String
        
        self.username = userDictionary["name"] as String
        
        let retweet_count = tweetInfo["retweet_count"] as Int
        self.retweetCount = String(retweet_count)
        
        let favorite_count = tweetInfo["favorite_count"] as Int
        self.favoriteCount = String(favorite_count)
        
        let profile_image_url = userDictionary["profile_image_url"] as String
        self.avatarUrl = NSURL(string: profile_image_url)
    }
 
    
    
    
    class func parseJSONDataIntoTweets(rawJSONData : NSData) -> [Tweet]? {
        var error : NSError?
        if let JSONArray = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSArray {
            
            var tweets = [Tweet]()
            
            for JSONDictionary in JSONArray {
                println(JSONDictionary)
                if let tweetDictionary = JSONDictionary as? NSDictionary {
                    var newTweet = Tweet(tweetInfo: tweetDictionary)
                    tweets.append(newTweet)
                }
            }
            
            // sort array of tweets alphabetically
            // looks at first item in array ($0) and compares to next item ($1)
//            tweets.sort({$0.text < $1.text})
            return tweets
        }
        return nil
    }
}