//
//  PersonViewController.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/11/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class PersonViewController: UIViewController {
    
    
    
    @IBOutlet weak var personFirstName: UITextField!
    @IBOutlet weak var personLastName: UITextField!
    @IBOutlet weak var personImage: UIImageView!
    
    var firstNamePassed : String!
    var lastNamePassed : String!
//    var imagePassed : UIImage!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personFirstName.text = firstNamePassed
        personLastName.text = lastNamePassed
//        personImage.image = imagePassed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
