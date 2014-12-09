//
//  ReminderTableViewController.swift
//  corelocationdemo
//
//  Created by Bradley Johnson on 11/5/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import UIKit
import CoreData

class ReminderTableViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext : NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "didGetCloudChanges:", name: NSPersistentStoreDidImportUbiquitousContentChangesNotification, object: appDelegate.persistentStoreCoordinator)
        
        self.tableView.dataSource = self
        
        var fetchRequest = NSFetchRequest(entityName: "Reminder")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Reminders")
        self.fetchedResultsController.delegate = self
        
        var error : NSError?
        if !self.fetchedResultsController.performFetch(&error) {
            println("error!!")
        }
        
//        self.reminders = self.managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as [Reminder]
//        if error != nil {
//            println(error?.localizedDescription)
//        } else {
//            self.tableView.reloadData()
//        }
        // Do any additional setup after loading the view.
    }
    
    func didGetCloudChanges( notification : NSNotification)
    {
        //self.managedObjectContext.performBlock { () -> Void in
            self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
        //}
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REMINDER_CELL", forIndexPath: indexPath) as UITableViewCell
        let reminder = self.fetchedResultsController.fetchedObjects?[indexPath.row] as Reminder
        
        cell.textLabel.text = reminder.name
        return cell
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
}
