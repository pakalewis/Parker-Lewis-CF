//
//  SingleUserVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/22/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class SingleUserVC: UIViewController {

    @IBOutlet var singleUserImageView: UIImageView!
    @IBOutlet var singleUserNameLabel: UILabel!

    
    var networkController : NetworkController!
    var currentUser : User?
    
    
    var frameToReturnImageTo: CGRect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.globalNetworkController

        
        self.singleUserNameLabel.text = self.currentUser?.userName
        self.singleUserImageView.image = UIImage(named: "default")

        
        self.networkController.downloadImage(self.currentUser!.avatarURL!, completionHandler: { (image) -> Void in
            self.singleUserImageView.image = image
        })

    

        // testing with the frame stuff
        println(UIScreen.mainScreen().bounds)
        println("on singleVC the singleUserImageView.frame is \(self.singleUserImageView.frame)")
        println("on singleVC the singleUserImageView.bounds is \(self.singleUserImageView.bounds)")
        println("the frame for the singleVC view is \(self.view.frame)")
    }
    
    
    
    
    @IBAction func goToUserOnGitHub(sender: AnyObject) {
        
        // initialize webVC
        var destinationVC = storyboard?.instantiateViewControllerWithIdentifier("WEB_VC") as WebVC
        
        // pass the user's github url
        destinationVC.initialURLString = self.currentUser!.userURL!
        
        self.navigationController?.pushViewController(destinationVC, animated: true)

        
    }
    
}
