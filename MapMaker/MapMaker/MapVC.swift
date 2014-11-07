//
//  MapVC.swift
//  MapMaker
//
//  Created by Parker Lewis on 11/3/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var managedObjectContext : NSManagedObjectContext!

    var currentNumberOfRegions = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("View did load")
        
        self.title = "Map"
        
        // Delegates
        self.appDelegate.locationManager.delegate = self
        self.managedObjectContext = self.appDelegate.managedObjectContext!
        self.mapView.delegate = self
        
        
        // Get authorization to access location
        switch CLLocationManager.authorizationStatus() as CLAuthorizationStatus {
        case .Authorized:
            println("authorized")
            //self.locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        case .NotDetermined:
            println("not determined")
            appDelegate.locationManager.requestAlwaysAuthorization()
        case .Restricted:
            println("restricted")
        case .Denied:
            println("denied")
        default:
            println("default")
        }
        
        
        // Set up gesture recognizer
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "longPressOnMap:")
        self.mapView.addGestureRecognizer(longPressGesture)
        
        
        // set up to observe when a region is created
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newRegionAdded:", name: "NEW_REGION_ADDED", object: nil)
    }
    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("View will appear")

        var fetchRequest = NSFetchRequest(entityName: "Reminder")
        var fetchResult = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil)
        
        if fetchResult?.count != self.currentNumberOfRegions {
            println("REFRESHING MAP BECAUSE NUMBER OF REGIONS CHANGED")
            self.clearMap()
            self.showReminders()
            self.currentNumberOfRegions = fetchResult!.count
        }

    }
    
    
    // TODO: this is not accurate. Some regions are not being monitored
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("View did appear")

        var totalRegions = appDelegate.locationManager.monitoredRegions
        for x in totalRegions {
            let region = x as CLRegion
        }
        println("Now monitoring \(totalRegions) total regions")
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    
    func clearMap() {
        println("removing all")
        self.mapView.removeOverlays(self.mapView.overlays)
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.reloadInputViews()
    }
    
    func showReminders() {
        var fetchRequest = NSFetchRequest(entityName: "Reminder")
//        var sortDescriptor = NSSortDescriptor(key: "identifier", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
        var fetchResult = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil)
        
        if fetchResult?.count > 0 {
            println("there are \(fetchResult!.count) results stored in core data")
            for result in fetchResult! {
                let reminder = result as Reminder
                
                var newAnnotation = MKPointAnnotation()
                newAnnotation.title = reminder.identifier
                newAnnotation.coordinate = reminder.makeCoordinate()
                self.mapView.addAnnotation(newAnnotation)

                let overlay = MKCircle(centerCoordinate: reminder.makeCoordinate(), radius: reminder.radius)
                self.mapView.addOverlay(overlay)
                
                
                // TODO: uncomment this to clear out any Reminders stored in core data
                //                 managedObjectContext.deleteObject(reminder)
                //                var error : NSError?
                //                managedObjectContext.save(&error)
                //                println("Reminder named \(reminder.identifier) at \(reminder.makeCoordinate().latitude) and \(reminder.makeCoordinate().longitude) with radius \(reminder.radius)")
            }
        } else {
            println("No Reminders stored yet")
        }
    }
    
    
    // this gets fired under the hood
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("YOU ARE ENTERING THE REGION \(region.identifier)")
        let enterNotification = UILocalNotification()
        enterNotification.fireDate = NSDate()
        enterNotification.alertBody = "You entered a special region"
        enterNotification.alertAction = "Title"
        
        UIApplication.sharedApplication().scheduleLocalNotification(enterNotification)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("YOU ARE EXITING THE REGION \(region.identifier)")
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("we got a location update!")
        
        if let location = locations.last as? CLLocation {
            println(location.coordinate.latitude)
            
        }
    }

    
    
    func longPressOnMap(sender: UILongPressGestureRecognizer) {
        println("User long pressed")
        if sender.state == UIGestureRecognizerState.Began {
            let pointTouched = sender.locationInView(self.mapView)
            let coordinate = self.mapView.convertPoint(pointTouched, toCoordinateFromView: self.mapView)
            self.mapView.setCenterCoordinate(coordinate, animated: true)
            println("\(coordinate.latitude) \(coordinate.longitude)")
            var newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = coordinate
            newAnnotation.title = "Add this region?"
            self.mapView.addAnnotation(newAnnotation)
        }
    }

    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        // Make renderer which draws the overlays on the map
        let renderer = MKCircleRenderer(overlay: overlay)
        
        // Adjust settings on the renderer
        renderer.fillColor = UIColor.greenColor().colorWithAlphaComponent(0.3)
        
        // Return it
        return renderer
    }
    
    // TODO: How to make two types of annotations. New ones have the callout button and previously set ones don't
    func mapView(aMapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKUserLocation {
            return nil
        }
        
        let dequeuedAnnotation = aMapView.dequeueReusableAnnotationViewWithIdentifier("REGION_ANNOTATION")
        if dequeuedAnnotation != nil {
            println("annotation was reused")
            return dequeuedAnnotation
        }
        
        let regionAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "REGION_ANNOTATION")
        regionAnnotation.animatesDrop = true
        regionAnnotation.canShowCallout = true
        
        let addAlertButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        regionAnnotation.rightCalloutAccessoryView = addAlertButton
        return regionAnnotation
    }
    
 
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
//        let remindersViewController = AddReminderViewController()
//        remindersViewController.delegate = self
//        remindersViewController.coordinate = view.annotation.coordinate
//        
//        let navController = UINavigationController(rootViewController: remindersViewController)
//        
//        navController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
//        navController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
//        navController.modalInPopover = true
//        
//        self.presentViewController(navController, animated: true, completion: nil)

        
        let newRegionVC = self.storyboard?.instantiateViewControllerWithIdentifier("NEW_REGION") as NewRegionVC
        newRegionVC.selectedAnnotation = view.annotation
        newRegionVC.mapRect = self.mapView.visibleMapRect
        
        let nav = UINavigationController(rootViewController: newRegionVC)
        self.presentViewController(nav, animated: true, completion: nil)
    }
 
    
    func newRegionAdded(notification : NSNotification) {
        println("new region added and notification fired")
        let userInfo = notification.userInfo!
        let newRegion = userInfo["region"] as CLCircularRegion
        
        let overlay = MKCircle(centerCoordinate: newRegion.center, radius: newRegion.radius)
        self.mapView.addOverlay(overlay)
    }
    
}
