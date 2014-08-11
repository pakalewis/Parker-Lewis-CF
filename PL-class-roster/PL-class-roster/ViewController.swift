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
    var rosterImages = [UIImage]()
    var rosterIndex: Int = 0

    
    var image1 : UIImage = UIImage(named:"archie-andrews.png")
    var image2 : UIImage = UIImage(named:"bugs-bunny.png")
    var image3 : UIImage = UIImage(named:"capn-crunch.png")
    var image4 : UIImage = UIImage(named:"donald-duck.png")

    

    // why doesn't this work??
    //    var person1 = Person(firstName: "Archie", lastName: "Andrews", image: image1)

    
    // create Person objects
    var person1 = Person(firstName: "Archie", lastName: "Andrews")
    var person2 = Person(firstName: "Bugs", lastName: "Bunny")
    var person3 = Person(firstName: "Cap'n", lastName: "Crunch")
    var person4 = Person(firstName: "Donald", lastName: "Duck")
    
    
    
    // this is the button in the navigation bar
    // how do I get stuff to display on the next page?
    @IBAction func moreInfoButton(sender: AnyObject) {
    }
    
    
    
    // press the button to display info in textbox and image view
    @IBAction func populateRoster(sender: AnyObject) {
        self.roster = self.makePersonArray(person1, person2, person3, person4)
        self.rosterImages = self.makeImagesArray(image1, image2, image3, image4)

        //display name in text box
        textBox.text = "Person number " + (String)(rosterIndex + 1) + " is \n\n" + roster[rosterIndex].fullName()

        //display image in image view
        personImage.image = rosterImages[rosterIndex]
        
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
    
    
    // function to make array of images
    // this shouldn't be necessary because my Person objects should be able to contain the images
    func makeImagesArray(images: UIImage...) -> [UIImage] {
        var rosterImages = [UIImage]()
        for i in images {
            rosterImages.append(i)
        }
        return rosterImages
    }
    
    
    
    

    
    
    
    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

