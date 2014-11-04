//
//  NewRegionVC.swift
//  MapMaker
//
//  Created by Parker Lewis on 11/3/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit
import MapKit

class NewRegionVC: UIViewController, UITextFieldDelegate {

    var locationManager : CLLocationManager!
    var selectedAnnotation : MKAnnotation!

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        
        self.myLabel.text = "Latitude: \(self.selectedAnnotation.coordinate.latitude)\nLongitude: \(self.selectedAnnotation.coordinate.longitude)"
        
    }
    
    
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func addRegionButton(sender: AnyObject) {
        
        
        println(self.textField.text)
        var newRegion = CLCircularRegion(center: self.selectedAnnotation.coordinate, radius: 100.0, identifier: self.textField.text)
        self.locationManager.startMonitoringForRegion(newRegion)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
