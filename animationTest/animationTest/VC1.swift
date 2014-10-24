//
//  VC1.swift
//  animationTest
//
//  Created by Parker Lewis on 10/23/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class VC1: UIViewController, UINavigationControllerDelegate {

    @IBOutlet var firstLabel: UILabel!

    var textToPass : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self
    }

    
    @IBAction func myButtonPressed(sender: AnyObject) {
        println("pressed")
        var destinationVC = storyboard?.instantiateViewControllerWithIdentifier("VC2") as VC2

        
        
//        self.textToPass = self.firstLabel.text
//        destinationVC.textThatWasPassed = self.textToPass

        
        
        self.navigationController?.pushViewController(destinationVC, animated: true)

        
    }

    
    
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // Check to make sure what the fromVC and toVCs are. If correct, implement animator files
        if let forwardAnimation = fromVC as? VC1 {
                let animator = ShowAnimation()
                return animator
        } else if let backwardAnimation = fromVC as? VC2 {
            let animator = HideAnimation()
            return animator
        }
        
        // All other transitions don't use any animations
        return nil
    }

    
    
}
