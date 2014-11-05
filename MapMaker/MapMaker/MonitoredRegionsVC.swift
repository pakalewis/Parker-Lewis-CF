//
//  MonitoredRegionsVC.swift
//  MapMaker
//
//  Created by Parker Lewis on 11/3/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MonitoredRegionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var managedObjectContext : NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController!
//    var monitoredRegions = [Reminder]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
//        self.tableView.delegate = self
        
        self.managedObjectContext = self.appDelegate.managedObjectContext!
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didGetCloudChanges:", name: NSPersistentStoreDidImportUbiquitousContentChangesNotification, object: appDelegate.persistentStoreCoordinator)

        
        // make a fetch request to core data to get all Reminders
        var fetchRequest = NSFetchRequest(entityName: "Reminder")
        var sortDescriptor = NSSortDescriptor(key: "identifier", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // initialize FRC
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Reminders")
        self.fetchedResultsController.delegate = self
        
        var error : NSError?
        if !self.fetchedResultsController.performFetch(&error) {
            println("error!!")
        }
    }

    
    func didGetCloudChanges(notification : NSNotification)
    {
        println("Did get cloud changes")
        //self.managedObjectContext.performBlock { () -> Void in
        self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
        //}
    }

    
    // MARK: - NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        println("reloading table view in controllerDidChangeContent")
        self.tableView.reloadData()
    }
    
    
    // MARK: Tableview funcs
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var retval = self.fetchedResultsController.fetchedObjects?.count ?? 0
        println("number of rows in section = \(retval)")
        return retval
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REGION_CELL", forIndexPath: indexPath) as UITableViewCell
        
        // get appropriate region
        let currentReminder = self.fetchedResultsController.fetchedObjects?[indexPath.row] as Reminder
        
        cell.textLabel.text = currentReminder.identifier
        return cell
    }
            
}
