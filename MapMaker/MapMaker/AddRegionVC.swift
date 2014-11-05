//
//  NewRegionVC.swift
//  MapMaker
//
//  Created by Parker Lewis on 11/3/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class NewRegionVC: UIViewController, UITextFieldDelegate {

    var selectedAnnotation : MKAnnotation!
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegates
        self.textField.delegate = self
        
        self.myLabel.text = "Latitude: \(self.selectedAnnotation.coordinate.latitude)\nLongitude: \(self.selectedAnnotation.coordinate.longitude)"
        
    }
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func addRegionButton(sender: AnyObject) {
        // Core Data
        let managedObjectContext = appDelegate.managedObjectContext!
        
        // First check to see if a Reminder with that identifier is already stored
        var fetchRequest = NSFetchRequest(entityName: "Reminder")
        fetchRequest.predicate = NSPredicate(format:"identifier = %@", self.textField.text)
        var fetchResult = managedObjectContext.executeFetchRequest(fetchRequest, error: nil)
        if fetchResult?.count > 0 {
            var duplicateAlert = UIAlertController(title: "", message: "There is already a reminder with this name", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            duplicateAlert.addAction(okAction)
            self.presentViewController(duplicateAlert, animated: true, completion: nil)
        }
        else {
            // Make new region to monitor
            var newRegionToMonitor = CLCircularRegion(center: self.selectedAnnotation.coordinate, radius: 20000.0, identifier: self.textField.text)
            println("new region called \(self.textField.text) added at \(newRegionToMonitor.center.latitude) and \(newRegionToMonitor.center.longitude)")
            appDelegate.locationManager.startMonitoringForRegion(newRegionToMonitor)

            // make new entity to store in core data
            let newReminderToStore = NSEntityDescription.insertNewObjectForEntityForName("Reminder", inManagedObjectContext: managedObjectContext) as Reminder
            newReminderToStore.identifier = self.textField.text
            newReminderToStore.date = NSDate()
            newReminderToStore.latitude = selectedAnnotation.coordinate.latitude
            newReminderToStore.longitude = selectedAnnotation.coordinate.longitude
            newReminderToStore.radius = newRegionToMonitor.radius
            
            var error : NSError?
            managedObjectContext.save(&error)
            if error != nil {
                println("There was an error saving to core data. The error says \(error!.localizedDescription)")
            }
            
            
            // Post a notification
            let newRegionNotification = NSNotification(name: "NEW_REGION_ADDED", object: nil, userInfo: ["region" : newRegionToMonitor])
            NSNotificationCenter.defaultCenter().postNotification(newRegionNotification)

            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
