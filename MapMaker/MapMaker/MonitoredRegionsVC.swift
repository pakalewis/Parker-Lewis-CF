//
//  MonitoredRegionsVC.swift
//  MapMaker
//
//  Created by Parker Lewis on 11/3/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit
import MapKit


class MonitoredRegionsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.locationManager.monitoredRegions.count
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REGION_CELL", forIndexPath: indexPath) as UITableViewCell
        
        // get appropriate region
        let monitoredRegions = appDelegate.locationManager.monitoredRegions.allObjects
        let currentRegion = monitoredRegions[indexPath.row] as CLRegion
        
        cell.textLabel.text = currentRegion.identifier
        return cell
    }
            
}
