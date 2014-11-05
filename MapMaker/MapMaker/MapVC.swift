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
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var regions = appDelegate.locationManager.monitoredRegions
        
        
        // Core Data stuff
        let managedObjectContext = appDelegate.managedObjectContext!
        
        var fetchRequest = NSFetchRequest(entityName: "Reminder")
        var sortDescriptor = NSSortDescriptor(key: "identifier", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        var fetchResult = managedObjectContext.executeFetchRequest(fetchRequest, error: nil)
        
        if fetchResult?.count > 0 {
            println("there are \(fetchResult?.count) results stored in core data")
            for result in fetchResult! {
                let reminder = result as Reminder
                println("Reminder named \(reminder.identifier) at \(reminder.makeCoordinate().latitude) and \(reminder.makeCoordinate().longitude)")
            }
        } else {
            println("No Reminders stored yet")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegates
        appDelegate.locationManager.delegate = self
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
    
    override func viewDidAppear(animated: Bool) {
//        var totalRegions = appDelegate.locationManager.monitoredRegions.count
//        var lastRegionAdded = appDelegate.locationManager.monitoredRegions.allObjects
//        println("Now monitoring \(totalRegions) total regions")
//        println("The latest region added was \(lastRegionAdded.last)")
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("YOU ARE ENTERING THE REGION \(region.identifier)")
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
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let regionAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "REGION_ANNOTATION")
        regionAnnotation.animatesDrop = true
        regionAnnotation.canShowCallout = true
        
        let addAlertButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        regionAnnotation.rightCalloutAccessoryView = addAlertButton
        return regionAnnotation
    }
    
 
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let newRegionVC = self.storyboard?.instantiateViewControllerWithIdentifier("NEW_REGION") as NewRegionVC
        newRegionVC.selectedAnnotation = view.annotation
        self.presentViewController(newRegionVC, animated: true, completion: nil)
    }
 
    
    func newRegionAdded(notification : NSNotification) {
        println("new region added and notification fired")
        let userInfo = notification.userInfo!
        let newRegion = userInfo["region"] as CLCircularRegion
        
        let overlay = MKCircle(centerCoordinate: newRegion.center, radius: newRegion.radius)
        self.mapView.addOverlay(overlay)
    }
    
}
