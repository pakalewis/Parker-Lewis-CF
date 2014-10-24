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
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as SingleUserVC
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserCollectionVC
        
        
        transitionContext.containerView().addSubview(toVC.view)
        toVC.view.alpha = 0.0
        
        let movingImage = UIImageView(frame: fromVC.singleUserImageView.frame)
        movingImage.clipsToBounds = true
        movingImage.contentMode = UIViewContentMode.ScaleAspectFill
        movingImage.image = fromVC.currentUser?.avatarImage
        transitionContext.containerView().addSubview(movingImage)

        
        UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: { () -> Void in

            println("hide animation firing")
//            movingImage.frame = fromVC.frameToReturnImageTo!
//            movingImage.frame = toVC.initialImageFrame!
            movingImage.frame = toVC.initialCellFrame!
            movingImage.alpha = 0.0
            fromVC.view.alpha = 0.0
            toVC.view.alpha = 1.0
            
        }) { (finished) -> Void in
            transitionContext.completeTransition(finished)
        }
    }
}
