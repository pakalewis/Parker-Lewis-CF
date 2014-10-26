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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    var networkController : NetworkController!
    var selectedUser : User?
    
    
    var frameToReturnImageTo: CGRect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.singleUserNameLabel.text = self.selectedUser?.userName
        self.singleUserImageView.image = UIImage(named: "default")
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color = UIColor.blackColor()


        
        NetworkController.controller.downloadImage(self.selectedUser!.avatarURL!, completionHandler: { (image) -> Void in
            self.activityIndicator.stopAnimating()
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
        destinationVC.initialURLString = self.selectedUser!.userURL!
        
        self.navigationController?.pushViewController(destinationVC, animated: true)

        
    }
    
}
