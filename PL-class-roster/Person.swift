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
    var firstName : String
    var lastName : String
    var image : UIImage?
    
    
    init (firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
 
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
}