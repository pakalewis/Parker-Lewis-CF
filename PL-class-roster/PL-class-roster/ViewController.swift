//
//  ViewController.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    //MARK: OUTLETS AND PROPERTIES
    @IBOutlet weak var tableView: UITableView!
    var sectionTitles = [String]()
    var roster = [Person]()
    var teachers = [Person]()
    var currentPerson = Person()
    var masterArray = [[Person]]()
    

    
    //MARK: VC LIFECYCLE
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
        var person8 = Person(firstName: "No", lastName: "Name")

        var teacher1 = Person(firstName: "Brad", lastName: "Johnson", image: UIImage(named:"teacher1.png"))
        var teacher2 = Person(firstName: "John", lastName: "Clem", image: UIImage(named:"teacher2.png"))

        //create the arrays of students and teachers
        self.roster = self.makePersonArray(person1, person2, person3, person4, person5, person6, person7, person8)
        self.teachers = self.makePersonArray(teacher1, teacher2)
        
        self.sectionTitles.append("Teachers")
        self.sectionTitles.append("Students")
        self.masterArray.append(self.teachers)
        self.masterArray.append(self.roster)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    
    
    
    
    
    


    
    
    //MARK: TABLEVIEW STUFF
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return sectionTitles[section]
    }

    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // currently returns 2 for teachers and roster
        return masterArray.count
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // returns count of the array within the master array
        return masterArray[section].count
    }
    
    

    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // set currentPerson
        currentPerson = self.masterArray[indexPath.section][indexPath.row]
        
        // display cell label
        cell.textLabel.text = currentPerson.fullName()
        return cell
    }
    

    
    
    //MARK: EXTRAS
    
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
        else if (segue.identifier == "AddPerson") {
            
            var newPerson = self.roster.last as Person!
            var personViewController = segue.destinationViewController as PersonViewController
            personViewController.currentDetailPerson = currentPerson
            
        }
    }
    
    
    @IBAction func addNewPerson(sender: AnyObject) {
        self.currentPerson = Person(firstName: "First:", lastName: "Last:")
//        masterArray[1].append(currentPerson)
//        self.tableView.reloadData()
        self.performSegueWithIdentifier("AddPerson", sender: self)
    }

    
    
    // new method to create array of Person objects
    func makePersonArray(people: Person...) -> [Person] {
        var array = [Person]()
        for i in people {
            array.append(i)
        }
        return array
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
    

}

