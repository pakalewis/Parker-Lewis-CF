//
//  MasterVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class MasterVC: UITableViewController, UINavigationControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("MasterVC viewDidLoad")
        // check if app loads for first time
        
        self.navigationController?.delegate = self
        
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("TESTING")
        
        // is this where I can dismiss this VC so it doesn't stay on screen on iPAD?
    }


    
    // move to USer collection VC
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // Check to make sure what the fromVC and toVCs are. If correct, implement animator files
        if let userCollectionVC = fromVC as? UserCollectionVC {
            if let singleUserVC = toVC as? SingleUserVC {
                let animator = AnimatorToSingleUser()
                animator.initialCellFrame = userCollectionVC.initialCellFrame
                animator.selectedImage = userCollectionVC.currentUser.avatarImage
                return animator                
            }
        }
        
        else if let singleUserVC = fromVC as? SingleUserVC {
            if let userCollectionVC = toVC as? UserCollectionVC {
                let animator = AnimatorBackToUserCollection()
                return animator                
            }
        }
        
        // All other transitions don't use any animations
        return nil
    }

}
