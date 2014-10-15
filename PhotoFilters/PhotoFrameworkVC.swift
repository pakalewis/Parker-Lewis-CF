//
//  PhotoFrameworkVC.swift
//  PhotoFilters
//
//  Created by Parker Lewis on 10/15/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import Photos

protocol FrameworkDelegate : class {
    func didSelectPicture(image: UIImage)
}

class PhotoFrameworkVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var photoFrameworkCollection : UICollectionView!
    weak var delegate : GalleryDelegate?
    
    var frameworkImageArray = [UIImage]()
    
    var imageManager: PHCachingImageManager!
    var assetFetchResults: PHFetchResult!
    var assetCollection: PHAssetCollection!
    var assetCellSize: CGSize!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // get image manager
        self.imageManager = PHCachingImageManager()
        // fetch all assets
        self.assetFetchResults = PHAsset.fetchAssetsWithOptions(nil)
        
        // get size of the device screen and use it to determine the asset cell size
        var scale = UIScreen.mainScreen().scale
        var flowLayout = self.photoFrameworkCollection.collectionViewLayout as UICollectionViewFlowLayout
        var cellSize = flowLayout.itemSize
        self.assetCellSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.photoFrameworkCollection.dequeueReusableCellWithReuseIdentifier("FRAMEWORK_CELL", forIndexPath: indexPath) as FrameworkCell
        let asset = self.assetFetchResults[indexPath.row] as PHAsset
        self.imageManager.requestImageForAsset(asset, targetSize: self.assetCellSize, contentMode: PHImageContentMode.AspectFill, options: nil) { (image, info) -> Void in
            self.frameworkImageArray.append(image)
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetFetchResults.count
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.didSelectPicture(self.frameworkImageArray[indexPath.row])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
