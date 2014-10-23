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
    
    var reverseOrigin: CGRect?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.singleUserNameLabel.text = self.currentUser?.userName
        self.singleUserImageView.image = self.currentUser?.avatarImage

    
    }
}
