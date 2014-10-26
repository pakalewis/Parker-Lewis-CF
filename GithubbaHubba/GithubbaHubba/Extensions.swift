//
//  Extensions.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/23/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation

extension String {
    
    func validateStringWithoutSpecialCharacters() -> Bool {
        
        let regex = NSRegularExpression(pattern: "[0-9a-zA-Z\n]", options: nil, error: nil)
        let range = NSRange(location: 0, length: countElements(self))
        let matches = regex?.numberOfMatchesInString(self, options: nil, range: range)
        
        if matches > 0 {
            return true
        }
        println("character not valid")
        return false
    }
}
