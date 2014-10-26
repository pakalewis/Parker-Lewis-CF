//
//  ProfileVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    var authenticatedUser : Profile?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var hirableLabel: UILabel!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

        
        
        if NetworkController.controller.authenticated {
            // returns true if authenticated so do the network call
            var urlSearchString = "https://api.github.com/user"
            let url = NSURL(string: urlSearchString)
            
            NetworkController.controller.fetchJSONData(url!, completionHandler: { (errorDescription, rawJSONData) -> (Void) in
                
                if errorDescription != nil {
                    println("there was an error getting the JSON")
                } else {
                    println("getting json for User")
                    self.authenticatedUser = NetworkController.controller.parseJSONDataForAuthenticatedUser(rawJSONData!)
                    self.populateLabels()
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
    
    
    func populateLabels() {
        NetworkController.controller.downloadImage(self.authenticatedUser!.avatar_url!, completionHandler: { (image) -> Void in
            self.imageView.image = image
        })
        
        self.nameLabel.text = self.authenticatedUser?.name
        self.userNameLabel.text = self.authenticatedUser?.login
        self.locationLabel.text = self.authenticatedUser?.location
        self.emailLabel.text = self.authenticatedUser?.email
        
        if self.authenticatedUser?.hirable != "0" {
            self.hirableLabel.text = "Hirable?  YES"
        } else {
            self.hirableLabel.text = "Hirable?  NO"
        }

    }

}
