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

    
    // encode to put in archiver
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
        if self.image != nil {
            aCoder.encodeObject(self.image!, forKey: "image")
        }
        if self.gitHubUserName != nil {
            aCoder.encodeObject(self.gitHubUserName!, forKey: "gitHubUserName")
        }
    }

    // take out of the archive
    required init(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObjectForKey("firstName") as String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as String
        self.image = aDecoder.decodeObjectForKey("image") as? UIImage
        self.gitHubUserName = aDecoder.decodeObjectForKey("gitHubUserName") as? String
        super.init()
    }
    
// initializers
    override init() {
        super.init()
    }

    init (firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
 
    init (firstName: String, lastName: String, image: UIImage) {
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
    }

// getters and setters
    
    
// functions/methods
    func fullName() -> String
    {
        return "\(firstName) \(lastName)"
    }
    
}