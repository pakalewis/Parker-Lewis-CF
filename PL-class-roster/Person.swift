//
//  Person.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit


class Person : NSObject, NSCoding {

// properties
    var firstName : String!
    var lastName : String!
    var image : UIImage?
    var gitHubUserName : String?
    var gitHubAvatar : UIImage?

    
    // encode to put in archiver
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
        aCoder.encodeObject(self.image, forKey: "image")
        aCoder.encodeObject(self.gitHubUserName, forKey: "gitHubUserName")
        aCoder.encodeObject(self.gitHubAvatar, forKey: "gitHubAvatar")

        
//        if self.image != nil {
//            aCoder.encodeObject(self.image!, forKey: "image")
//        }
//        if self.gitHubUserName != nil {
//            aCoder.encodeObject(self.gitHubUserName!, forKey: "gitHubUserName")
//        }
//        if self.gitHubAvatar != nil {
//            aCoder.encodeObject(self.gitHubAvatar!, forKey: "gitHubAvatar")
//        }
    }

    // take out of the archive
    required init(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObjectForKey("firstName") as String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as String
        self.image = aDecoder.decodeObjectForKey("image") as? UIImage
        self.gitHubUserName = aDecoder.decodeObjectForKey("gitHubUserName") as? String
        self.gitHubAvatar = aDecoder.decodeObjectForKey("gitHubAvatar") as? UIImage
        
        
//        if let myImage = aDecoder.decodeObjectForKey("image") as? UIImage {
//            self.image = myImage
//        }
//        if let myGitHubUserName = aDecoder.decodeObjectForKey("gitHubUserName") as? String {
//            self.gitHubUserName = aDecoder.decodeObjectForKey("gitHubUserName") as? String
//        }
//        if let myGitHubAvatar = aDecoder.decodeObjectForKey("gitHubAvatar") as? UIImage {
//            self.gitHubAvatar = aDecoder.decodeObjectForKey("gitHubAvatar") as? UIImage
//        }
        super.init()
    }
    
// initializers
    override init() {
        self.firstName = ""
        self.lastName = ""
        self.image = UIImage(named: "nopic")
        self.gitHubUserName = ""
        self.gitHubAvatar = UIImage(named: "nopic")
    }

    init (firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.image = UIImage(named: "nopic")
        self.gitHubUserName = ""
        self.gitHubAvatar = UIImage(named: "nopic")
    }
 
    init (firstName: String, lastName: String, image: UIImage) {
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.gitHubUserName = ""
        self.gitHubAvatar = UIImage(named: "nopic")        
    }

// getters and setters
    
    
// functions/methods
    func fullName() -> String
    {
        return "\(firstName) \(lastName)"
    }
    
}