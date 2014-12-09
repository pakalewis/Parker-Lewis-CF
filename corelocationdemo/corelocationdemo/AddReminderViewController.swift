//
//  AddReminderViewController.swift
//  corelocationdemo
//
//  Created by Bradley Johnson on 11/3/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class AddReminderViewController: UIViewController {
    
    var locationManager : CLLocationManager!
    var selectedAnnotation : MKAnnotation!
    var managedObjectContext : NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        
//        let regionSet = self.locationManager.monitoredRegions
//        let regions = regionSet.allObjects
        
        // Do any additional setup after loading the view.
    }

    @IBAction func didPressAddReminderButton(sender: AnyObject) {
        
        var geoRegion = CLCircularRegion(center: selectedAnnotation.coordinate, radius: 4000.0, identifier: "TestRegion")
        self.locationManager.startMonitoringForRegion(geoRegion)
        
        //insert a reminder into the our DB
        var newReminder = NSEntityDescription.insertNewObjectForEntityForName("Reminder", inManagedObjectContext: self.managedObjectContext) as Reminder
        newReminder.name = "TestRegion"
        
        var error : NSError?
        self.managedObjectContext.save(&error)
        
        //error checking
        if error != nil {
            println(error?.localizedDescription)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("REMINDER_ADDED", object: self, userInfo: ["region" : geoRegion])
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
