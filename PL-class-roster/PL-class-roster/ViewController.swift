//
//  ViewController.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nextPage: UIBarButtonItem!

    var roster = [Person]()
    var rosterIndex: Int = 0

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // initialize Person objects
        var person1 = Person(firstName: "Archie", lastName: "Andrews", image: UIImage(named:"archie-andrews.png"))
        var person2 = Person(firstName: "Bugs", lastName: "Bunny", image: UIImage(named:"bugs-bunny.png"))
        var person3 = Person(firstName: "Cap'n", lastName: "Crunch", image: UIImage(named:"capn-crunch.png"))
        var person4 = Person(firstName: "Donald", lastName: "Duck", image: UIImage(named:"donald-duck.png"))
        
        //create the array of people
        self.roster = self.makePersonArray(person1, person2, person3, person4)
    }
    

    
    
    
    // this is the button in the navigation bar
    // how do I get stuff to display on the next page?
    
//    @IBAction func moreInfoButton(segue: UIStoryboardSegue!, sender: AnyObject) {
//        var nextView = segue!.destinationViewController as PersonViewController
//        nextView. = roster[rosterIndex]
//    }
    
    
    
    
    
    // press the button to display info in textbox and image view
    @IBAction func populateRoster(sender: AnyObject) {

        //display name in text box
        textBox.text = "Person number " + (String)(rosterIndex + 1) + " is \n\n" + roster[rosterIndex].fullName()


        //display image in image view
        personImage.image = roster[rosterIndex].image
        
        
        // cycle through the arrays and reset to zero if the index reaches the end
        rosterIndex++
        if rosterIndex == roster.count { rosterIndex = 0 }
    }
    
    
    
    
    
    
    // new method to create array of Person objects
    func makePersonArray(people: Person...) -> [Person] {
        var roster = [Person]()
        for i in people {
            roster.append(i)
        }
        return roster
    }
    
    
    
    
    
    
    
                            

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

