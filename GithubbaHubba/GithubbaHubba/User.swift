//
//  User.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/22/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class User {
    var userName : String?
    var userURL : String?
    var avatarURL : String?
    var avatarImage : UIImage?
    
    init() {
        self.userName = ""
        self.avatarImage = UIImage(named: "default")
    }
    
    init (name: String, url: String, avatarURL: String) {
        self.userName = name
        self.userURL = url
        self.avatarURL = avatarURL
    }

}