//
//  MasterVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class MasterVC: UITableViewController {

    var networkController : NetworkController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("MasterVC viewDidLoad")
        // check if app loads for first time
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.globalNetworkController
        
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        
        // check to see if OAuth token is saved in NSUserDefaults
        if let tokenCheck = userDefaults.objectForKey("OauthToken") as? String {
            // token already stored
            println("Authorized token already saved: \(tokenCheck)")
            self.networkController.setupAuthenticatedSession()
        } else {
            // no token so fire the NetworkController that requests authorization
            self.networkController.requestOAuthAccess()
        }
        
        
    }


}
