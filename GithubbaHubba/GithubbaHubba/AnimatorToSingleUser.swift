//
//  AnimatorToSingleUser.swift
//  Pinchot
//
//  Created by Andrew Shepard on 10/21/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

import UIKit

class AnimatorToSingleUser: NSObject, UIViewControllerAnimatedTransitioning {
    
    var initialCellFrame : CGRect?
    var selectedImage : UIImage?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserCollectionVC
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as SingleUserVC

        toVC.view.alpha = 0.0
        transitionContext.containerView().addSubview(toVC.view)
        
        let movingImage = UIImageView(frame: self.initialCellFrame!)
        movingImage.backgroundColor = UIColor.lightGrayColor()
        movingImage.clipsToBounds = true
        movingImage.contentMode = UIViewContentMode.ScaleAspectFill
        movingImage.image = self.selectedImage
        transitionContext.containerView().addSubview(movingImage)
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            println("show animation firing")

            // fade
            fromVC.view.alpha = 0.0
            toVC.view.alpha = 1.0
            
            
            movingImage.frame = toVC.singleUserImageView.frame
            println("what the movingImage frame will be set to:\(toVC.singleUserImageView.frame)")
            movingImage.alpha = 0.0
            
            
            }) { (finished) -> Void in
                transitionContext.completeTransition(finished)
        }
    }
}
