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
        
        // this will be in the if else that is commented out below
        self.networkController.requestOAuthAccess()

        
        // this grabs the stored firstLaunchBool and determines wether to call requestOAuthAccess()
        // also check to see if a token was stored or not
//        let firstLaunchBool = NSUserDefaults.standardUserDefaults().boolForKey("firstTimeLaunchingApp")
//        if firstLaunchBool {
//            println("calling requestOAuthAccess() from MasterVC")
//            self.networkController.requestOAuthAccess()
//        } else {
//            // app already launched and OAuthAccess should be set up already
//        }

        
    }


}
