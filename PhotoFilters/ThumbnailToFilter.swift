//
//  ThumbnailToFilter.swift
//  PhotoFilters
//
//  Created by Parker Lewis on 10/14/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ThumbnailToFilter {
    var originalThumbnail : UIImage
    var filterName : String
    var imageQueue : NSOperationQueue?
    var gpuContext : CIContext?
    var filteredThumbnail : UIImage?
    
    init(thumb : UIImage, name : String) {
        self.originalThumbnail = thumb
        self.filterName = name
    }

    func applyFilter (completionHandler : (image : UIImage) -> Void) {
        self.imageQueue = NSOperationQueue()
        var options = [kCIContextWorkingColorSpace : NSNull()]
        var myEAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.gpuContext = CIContext(EAGLContext: myEAGLContext, options: options)
        
        self.imageQueue?.addOperationWithBlock({ () -> Void in
            var ciImage = CIImage(image: self.originalThumbnail)
            var imageFilter = CIFilter(name: self.filterName)
            imageFilter.setDefaults()
            imageFilter.setValue(ciImage, forKey: kCIInputImageKey)
            var result = imageFilter.valueForKey(kCIOutputImageKey) as CIImage
            var extent = result.extent()
            var imageRef = self.gpuContext?.createCGImage(result, fromRect: extent)
            self.filteredThumbnail = UIImage(CGImage: imageRef)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionHandler(image: self.filteredThumbnail!)
            })
        })
    }
}

