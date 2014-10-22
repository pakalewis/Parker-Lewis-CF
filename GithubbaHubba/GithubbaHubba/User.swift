//
//  User.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/22/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation

class User {
    var userName : String?
    var userURL : String?
    var avatarURL : String?
    
    init (name: String, url: String, avatarURL: String) {
        self.userName = name
        self.userURL = url
        self.avatarURL = avatarURL
    }

}