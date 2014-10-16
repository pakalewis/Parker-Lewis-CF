//
//  ReactToPinch.swift
//  PhotoFilters
//
//  Created by Parker Lewis on 10/16/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit


class ReactToPinch: NSObject {
    
    var collectionView : UICollectionView?
//    var pinchGestureRecognizer : UIPinchGestureRecognizer?
    var flowLayout : UICollectionViewFlowLayout?
    
    override init() {
        
    }
    
    func pinchAction(pinchGesture: UIPinchGestureRecognizer) {
        if pinchGesture.state == UIGestureRecognizerState.Ended {
            self.collectionView!.performBatchUpdates({ () -> Void in
                var currentWidth = self.flowLayout!.itemSize.width
                var currentHeight = self.flowLayout!.itemSize.height
                if pinchGesture.velocity > 0 {
                    self.flowLayout!.itemSize = CGSize(width: currentWidth * 2, height: currentHeight * 2)
                } else {
                    self.flowLayout!.itemSize = CGSize(width: currentWidth * 0.5, height: currentHeight * 0.5)
                }
            }, completion: nil )
        }
    }
   
}
