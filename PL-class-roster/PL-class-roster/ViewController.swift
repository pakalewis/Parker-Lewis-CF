//
//  ViewController.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var roster = [Person]()
    var currentPerson = Person(firstName: "First: ", lastName: "Last: ")

    

    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // talk to the tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // initialize Person objects
        var person1 = Person(firstName: "Archie", lastName: "Andrews", image: UIImage(named:"archie-andrews.png"))
        var person2 = Person(firstName: "Bugs", lastName: "Bunny", image: UIImage(named:"bugs-bunny.png"))
        var person3 = Person(firstName: "Cap'n", lastName: "Crunch", image: UIImage(named:"capn-crunch.png"))
        var person4 = Person(firstName: "Donald", lastName: "Duck", image: UIImage(named:"donald-duck.png"))
        var person5 = Person(firstName: "Eeyore", lastName: "", image: UIImage(named:"eeyore.png"))
        var person6 = Person(firstName: "Fred", lastName: "Flintstone", image: UIImage(named:"fred-flintstone.png"))
        var person7 = Person(firstName: "Goofy", lastName: "", image: UIImage(named:"goofy.png"))
        
        //create the array of people
        self.roster = self.makePersonArray(person1, person2, person3, person4, person5, person6, person7)
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
    }

    
    
    // tableView stuff
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return roster.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var personInRow = self.roster[indexPath.row]
        cell.textLabel.text = personInRow.fullName()
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    }

    
    
    
    
    // pass data to the other view controller
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "personSegue") {

            // get the index of the selected cell in the table
            var selectedIndexPath = self.tableView.indexPathForSelectedRow()
            
            // set the Person object for this ViewController class by using the correct index in the roster
            self.currentPerson = self.roster[selectedIndexPath.row]
            
            // target the next view controller
            var personViewController = segue.destinationViewController as PersonViewController
            
            // set the target VC Person object
            personViewController.currentPerson = currentPerson
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    

}

