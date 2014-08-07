//
//  ViewController.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var textBox: UITextView!
    var people = [Person]()
    
// make the text box display stuff when toggling the switch
    @IBAction func changer(sender: AnyObject) {
        var newTitle = "test"
        if mySwitch.on {
            textBox.text = me.fullName() + "\n" + person1.fullName() + "\n" + person2.fullName() + "\n" + person3.fullName()
        }
        else {
            textBox.text = ""
        }
    }

// test Person objects
    var me = Person(firstName: "Parker", lastName: "Lewis")
    self.people.append(me)
    var person1 = Person(firstName: "Alice", lastName: "Adams")
    self.people.append(person1)
    var person2 = Person(firstName: "Beth", lastName: "Brown")
    self.people.append(person2)
    var person3 = Person(firstName: "Chester", lastName: "Charles")
    self.people.append(person3)
    
    
// new method to create array of Person objects
    func makePersonArray(people: Person...) -> [Person] {
        var roster = [Person]()
        for i in people {
            roster.append(i)
        }
        return roster
    }
    
    
    
    

// two attempts at making an array of Person objects - why the error?!?
    
//    let classRoster = [Person: person1, Person: person2, Person: person3]
    
    
//    var classRoster = makePersonArray(Person: person1, Person:  person2, Person: person3)

    
    
    
    
    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

