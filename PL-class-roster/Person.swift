//
//  Person.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit


class Person {

// properties
    var firstName : String
    var lastName : String
    var image : UIImage?
    
// initializers
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
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
}