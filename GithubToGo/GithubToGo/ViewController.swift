//
//  ViewController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 10/20/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstLaunch = true
    
    var networkController : NetworkController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        self.networkController.requestOAuthAccess()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

