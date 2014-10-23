//
//  Repo.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class Repo {
    var name : String
    var url : String
    var avatarURL : String
    var avatarImage : UIImage?
    
    init() {
        self.name = ""
        self.url = ""
        self.avatarURL = ""
    }
    
    init (name: String, url: String, repoAvatarURL: String) {
        self.name = name
        self.url = url
        self.avatarURL = repoAvatarURL
    }
}