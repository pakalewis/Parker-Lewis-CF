//
//  MapVC.swift
//  MapMaker
//
//  Created by Parker Lewis on 11/3/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
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
    }
    
    override func viewDidAppear(animated: Bool) {
        var totalRegions = appDelegate.locationManager.monitoredRegions.count
        var lastRegionAdded = appDelegate.locationManager.monitoredRegions.allObjects
        println("Now monitoring \(totalRegions) total regions")
        println("The latest region added was \(lastRegionAdded.last)")
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
        newRegionVC.locationManager = appDelegate.locationManager
        newRegionVC.selectedAnnotation = view.annotation
        self.presentViewController(newRegionVC, animated: true, completion: nil)
    }
 
    
}
