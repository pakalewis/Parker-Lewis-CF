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
    var sectionTitles = [String]()
    var roster = [Person]()
    var teachers = [Person]()
    var currentPerson = Person()
    

    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        talk to the tableView ---- I hooked these up in the storyboard
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
        
        
        // initialize Person objects
        var person1 = Person(firstName: "Archie", lastName: "Andrews", image: UIImage(named:"archie-andrews.png"))
        var person2 = Person(firstName: "Bugs", lastName: "Bunny", image: UIImage(named:"bugs-bunny.png"))
        var person3 = Person(firstName: "Cap'n", lastName: "Crunch", image: UIImage(named:"capn-crunch.png"))
        var person4 = Person(firstName: "Donald", lastName: "Duck", image: UIImage(named:"donald-duck.png"))
        var person5 = Person(firstName: "Eeyore", lastName: "", image: UIImage(named:"eeyore.png"))
        var person6 = Person(firstName: "Fred", lastName: "Flintstone", image: UIImage(named:"fred-flintstone.png"))
        var person7 = Person(firstName: "Goofy", lastName: "", image: UIImage(named:"goofy.png"))

        var teacher1 = Person(firstName: "Brad", lastName: "Johnson", image: UIImage(named:"teacher1.png"))
        var teacher2 = Person(firstName: "John", lastName: "Clem", image: UIImage(named:"teacher2.png"))

        //create the arrays of students and teachers
        self.roster = self.makePersonArray(person1, person2, person3, person4, person5, person6, person7)
        self.teachers = self.makePersonArray(teacher1, teacher2)
        
        self.sectionTitles.append("Teachers")
        self.sectionTitles.append("Students")

        println("VC view did load")
        println("full name: " + currentPerson.fullName())
        println("\n")
        
    }
    
    
    
    
    // new method to create array of Person objects
    func makePersonArray(people: Person...) -> [Person] {
        var array = [Person]()
        for i in people {
            array.append(i)
        }
        return array
    }
    
    
    
    


    
    
    // tableView stuff
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return sectionTitles[section]
    }

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
    }
    
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {

        // determine number of rows base on the two arrays
        if section == 0 { return teachers.count }
        else { return roster.count }
    }
    
    
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // set currentPerson
        if indexPath.section == 0 {
            currentPerson = self.teachers[indexPath.row]
        }
        else {
            currentPerson = self.roster[indexPath.row]
        }
        
        // display cell label
        cell.textLabel.text = currentPerson.fullName()
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
    }

    
    
    
    
    // pass data to the other view controller
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "personSegue") {

            // get the index of the selected cell in the table
            var selectedIndexPath = self.tableView.indexPathForSelectedRow()
            
            // set the currentPerson which is what will be passed
            if selectedIndexPath.section == 0 {
                self.currentPerson = self.teachers[selectedIndexPath.row]
            }
            else {
                self.currentPerson = self.roster[selectedIndexPath.row]
            }

            
            // target the next view controller
            var personViewController = segue.destinationViewController as PersonViewController
            
            // set the target VC Person object
            personViewController.currentDetailPerson = self.currentPerson
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
    

}

