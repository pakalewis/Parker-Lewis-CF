//
//  MasterVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class MasterVC: UITableViewController, UINavigationControllerDelegate {

    var networkController : NetworkController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("MasterVC viewDidLoad")
        // check if app loads for first time
        
        self.navigationController?.delegate = self
        
    }

    
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // This is called whenever during all navigation operations
        
        // Only return a custom animator for two view controller types
        if let mainViewController = fromVC as? UserCollectionVC {
            if let toViewController = toVC as? SingleUserVC {
                let animator = ShowImageAnimator()
                animator.origin = mainViewController.origin
                
                return animator                
            }
        }
        else if let imageViewController = fromVC as? SingleUserVC {
            let animator = HideImageAnimator()
            animator.origin = imageViewController.reverseOrigin
            
            return animator
        }
        
        println("navController func fired")
        
        // All other types use default transition
        return nil
    }

}
