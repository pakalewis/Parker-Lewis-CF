//
//  ShowAnimation.swift
//  animationTest
//
//  Created by Parker Lewis on 10/23/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class ShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
 
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 2.0
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as VC1
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as VC2
        transitionContext.containerView().addSubview(toVC.view)
        toVC.view.alpha = 0.0
        
        toVC.view.frame = fromVC.firstLabel.frame
        
        
        
        
        UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            println("show animation firing")
            fromVC.view.alpha = 0.0
            toVC.view.alpha = 1.0

            toVC.view.frame = UIScreen.mainScreen().bounds

            
            }) { (finished) -> Void in

//                fromVC.view.alpha = 0.0
//                toVC.view.alpha = 1.0
                
                // And tell the transitionContext we're done
                transitionContext.completeTransition(finished)
                
                
        }
    }    
    
}