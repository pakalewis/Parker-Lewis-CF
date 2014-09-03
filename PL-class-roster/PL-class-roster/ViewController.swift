//
//  ViewController.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    //MARK: OUTLETS AND PROPERTIES
    @IBOutlet weak var tableView: UITableView!
    var sectionTitles = ["Teachers", "Students"]
    var roster = [Person]()
    var teachers = [Person]()
    var currentPerson = Person()
    var masterArray = [[Person]]()
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    

    
    //MARK: VC LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        println("main viewController view did load")
        if let unarchivedData = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsPath + "/archive") as? [[Person]] {
            if unarchivedData.count > 0 {
                println("unarchivedData is NOT EMPTY")
                self.teachers = unarchivedData[0]
                self.roster = unarchivedData[1]
                self.makeMasterArray()
            }
        }
        else {
            println("App is opened for the first time - unarchivedData is EMPTY")
            self.loadSampleData()
        }
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        if NSKeyedArchiver.archiveRootObject(self.masterArray, toFile: documentsPath + "/archive") {
            println("able to archive")
        }
        else {
            println("not able to archive")
        }
    }
    
    
    
    
    
    //MARK: TABLEVIEW STUFF
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return sectionTitles[section]
    }

    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {

        if editingStyle == UITableViewCellEditingStyle.Delete {
            if indexPath.section == 0 {
                teachers.removeAtIndex(indexPath.row)
            } else {
                roster.removeAtIndex(indexPath.row)
            }
            makeMasterArray()
            self.tableView.reloadData()
            self.viewWillAppear(true)
        }
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
        cell.imageView.image = currentPerson.image
        return cell
    }
    

    
    
    //MARK: EXTRAS
    // create array of sample data
    func loadSampleData() {
        // initialize Person objects
        var teacher1 = Person(firstName: "Brad", lastName: "Johnson", image: UIImage(named:"teacher1.png"))
        var teacher2 = Person(firstName: "John", lastName: "Clem", image: UIImage(named:"teacher2.png"))
        var testPerson = Person(firstName: "aaTest", lastName: "test")
        var person1 = Person(firstName: "Archie", lastName: "Andrews", image: UIImage(named:"archie-andrews.png"))
        var person2 = Person(firstName: "Bugs", lastName: "Bunny", image: UIImage(named:"bugs-bunny.png"))
        var person3 = Person(firstName: "Cap'n", lastName: "Crunch", image: UIImage(named:"capn-crunch.png"))
        var person4 = Person(firstName: "Donald", lastName: "Duck", image: UIImage(named:"donald-duck.png"))
//        var person5 = Person(firstName: "Eeyore", lastName: "", image: UIImage(named:"eeyore.png"))
//        var person6 = Person(firstName: "Fred", lastName: "Flintstone", image: UIImage(named:"fred-flintstone.png"))
//        var person7 = Person(firstName: "Goofy", lastName: "", image: UIImage(named:"goofy.png"))
//        var person8 = Person(firstName: "Hobbes", lastName: "", image: UIImage(named: "hobbes"))
        
        
        //create the arrays of students and teachers
        self.teachers = [teacher1, teacher2]
        self.roster = [testPerson, person1, person2, person3, person4]
        makeMasterArray()
    }

    
    // set up segue to pass data to the other view controller when clicking on a cell in tableview
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // target the next view controller
        var personViewController = segue.destinationViewController as PersonViewController

        // if clicking a cell in the tableview, target the correct Person obj
        if (segue.identifier == "personSegue") {
            // get the index of the selected cell in the table
            var selectedIndexPath = self.tableView.indexPathForSelectedRow()
            
            // set the currentPerson which is what will be passed
            self.currentPerson = masterArray[selectedIndexPath.section][selectedIndexPath.row]
        }

        // set the target VC Person object
        personViewController.currentDetailPerson = self.currentPerson
    }
    
    
    // button for adding a new Person to student array
    @IBAction func addNewPerson(sender: AnyObject) {
        // make new blank person and add to the specified array
        self.currentPerson = Person()

        var roleAlert = UIAlertController(title: "Add student or teacher?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        roleAlert.addAction(UIAlertAction(title: "Student", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction!) in
            self.roster.append(self.currentPerson)
            self.makeMasterArray()
            self.performSegueWithIdentifier("AddPerson", sender: self)
        }))
        roleAlert.addAction(UIAlertAction(title: "Teacher", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction!) in
            self.teachers.append(self.currentPerson)
            self.makeMasterArray()
            self.performSegueWithIdentifier("AddPerson", sender: self)
        }))
        self.presentViewController(roleAlert, animated: true, completion: nil)
    }

    
    // refresh masterArray after adding or deleting a Person
    func makeMasterArray() {
        var makeMasterArray = [[Person]]()
        makeMasterArray.append(self.teachers)
        makeMasterArray.append(self.roster)
        self.masterArray = makeMasterArray
    }
    
    
    
    

}

