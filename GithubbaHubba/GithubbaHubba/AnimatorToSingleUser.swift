//
//  AnimatorToSingleUser.swift
//  Pinchot
//
//  Created by Andrew Shepard on 10/21/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

import UIKit

class AnimatorToSingleUser: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()

        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserCollectionVC
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as SingleUserVC

        // set initial state for toVC
        toVC.view.alpha = 0.0
        
        let collectionView = fromVC.collectionView
        let index = collectionView.indexPathsForSelectedItems()?.first as NSIndexPath
        let cell = collectionView.cellForItemAtIndexPath(index) as UserCell
        fromVC.initialImageFrame = fromVC.view.convertRect(cell.userAvatarImageView.frame, fromView: cell.userAvatarImageView)
        
        // trick from Andy. this gets a view from a given frame
        let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        let movingImageView = cell.userAvatarImageView.resizableSnapshotViewFromRect(cell.userAvatarImageView.bounds, afterScreenUpdates: false, withCapInsets: insets)
        movingImageView.frame = fromVC.initialImageFrame!

        
        // add to container view
        containerView.addSubview(toVC.view)
        containerView.addSubview(movingImageView)
        
        // begin animation
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            println("show animation firing")

            // fade
            fromVC.view.alpha = 0.0
            toVC.view.alpha = 1.0
            
            // WTF I CANT FIGURE OUT HOW TO GET movingImageView TO GO TO THE CORRECT FRAME ON THE SingleUserVC (toVC)
//            let finalFrame = toVC.singleUserImageView.convertRect(toVC.singleUserImageView.frame, fromView: toVC.singleUserImageView)
//            let finalFrame = toVC.view.convertRect(toVC.singleUserImageView.frame, fromView: toVC.singleUserImageView)
//            println(finalFrame)
//            movingImageView.frame = finalFrame
            movingImageView.frame = toVC.singleUserImageView.frame
            movingImageView.alpha = 0.0
            
            
            }) { (finished) -> Void in
                transitionContext.completeTransition(finished)
        }
    
    }
}
