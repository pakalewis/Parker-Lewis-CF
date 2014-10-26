//
//  AnimatorBackToUserCollection.swift
//  Pinchot
//
//  Created by Andrew Shepard on 10/21/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

import UIKit

class AnimatorBackToUserCollection: NSObject, UIViewControllerAnimatedTransitioning {
    
    // Rectangle denoting where the animation should start from
    // Used for positioning the toViewController's view
    var origin: CGRect?    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()

        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as SingleUserVC
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserCollectionVC
        
        // set initial state for toVC
        toVC.view.alpha = 0.0
        
        // trick from Andy. this gets a view from a given frame
        let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        let shrinkingImage = fromVC.singleUserImageView.resizableSnapshotViewFromRect(fromVC.singleUserImageView.bounds, afterScreenUpdates: false, withCapInsets: insets)
//        shrinkingImage.frame = fromVC.view.convertRect(fromVC.singleUserImageView.frame, fromView: fromVC.singleUserImageView)
        shrinkingImage.frame = fromVC.singleUserImageView.frame
        // UGH AGAIN THE SAME PROBLEM. I CANT SEEM TO GRAB THE CORRECT FRAME. WHY????
        
        // add to container view
        containerView.addSubview(toVC.view)
        containerView.addSubview(shrinkingImage)

        // begin animation
        UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: { () -> Void in

            fromVC.view.alpha = 0.0
            toVC.view.alpha = 1.0
            
            shrinkingImage.frame = toVC.initialImageFrame!
            shrinkingImage.alpha = 0.0
            
        }) { (finished) -> Void in
            transitionContext.completeTransition(finished)
        }
    }


}
