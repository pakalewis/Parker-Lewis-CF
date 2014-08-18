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
    var currentDetailPerson = Person(firstName: "First: ", lastName: "Last: ")
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personFirstName.text = currentDetailPerson.firstName
        personLastName.text = currentDetailPerson.lastName
        personImage.image = currentDetailPerson.image
    }
    
    override func viewWillDisappear(animated: Bool) {
//        currentDetailPerson.firstName = personFirstName.text
//        currentDetailPerson.lastName = personLastName.text
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if ( segue.identifier == "saveChangesAndGoBack") {
            var backToTableView = segue.destinationViewController as ViewController
            currentDetailPerson.firstName = personFirstName.text
            currentDetailPerson.lastName = personLastName.text
            backToTableView.currentPerson = self.currentDetailPerson
            // how do I target the correct cell in the table to change the data??????
            // do i need this button or can I use the navigation controller's "back" button
            
        }
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
