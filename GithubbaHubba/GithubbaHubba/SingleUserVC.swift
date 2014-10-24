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

    var currentUser : User?
    
    
    var frameToReturnImageTo: CGRect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.singleUserNameLabel.text = self.currentUser?.userName
//        self.singleUserImageView.image = self.currentUser?.avatarImage
        self.singleUserImageView.image = UIImage(named: "default")

        
        println(UIScreen.mainScreen().bounds)
        println("on singleVC the singleUserImageView.frame is \(self.singleUserImageView.frame)")
        println("on singleVC the singleUserImageView.bounds is \(self.singleUserImageView.bounds)")
        println("the frame for the singleVC view is \(self.view.frame)")
    
    }
}
