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
    
    var currentPerson : Person?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personFirstName.text = currentPerson?.firstName
        personLastName.text = currentPerson?.lastName
        personImage.image = currentPerson?.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
