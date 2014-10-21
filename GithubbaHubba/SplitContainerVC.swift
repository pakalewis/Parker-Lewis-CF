//
//  SplitContainerVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class SplitContainerVC: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let splitVC = self.childViewControllers[0] as UISplitViewController
        splitVC.delegate = self

    }
    
    
    // this shows the master VC first rather than the detail VC
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        return true
    }




}
