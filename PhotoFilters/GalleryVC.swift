//
//  GalleryVC.swift
//  PhotoFilters
//
//  Created by Parker Lewis on 10/13/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

protocol GalleryDelegate {
    func didSelectPicture(image: UIImage)
}

class GalleryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var galleryHeader : GalleryHeader?
    var imageArray = [UIImage]()
    var delegate : GalleryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        var image1 = UIImage(named: "1.jpg")
        var image2 = UIImage(named: "2.jpg")
        var image3 = UIImage(named: "3.jpeg")
        
        self.imageArray.append(image1)
        self.imageArray.append(image2)
        self.imageArray.append(image3)
        
        galleryCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "GALLERY_HEADER")
        galleryCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "GALLERY_FOOTER")
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GALLERY_CELL", forIndexPath: indexPath) as GalleryCell
        cell.imageView.image = self.imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.didSelectPicture(self.imageArray[indexPath.row])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//
//        let makeHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "GALLERY_HEADER", forIndexPath: indexPath) as GalleryHeader
//            makeHeader.headerLabel.text = "IMAGES"
//        self.galleryHeader = makeHeader as GalleryHeader
//        return makeHeader
    
        
        
        
        //        if kind == UICollectionElementKindSectionHeader {
//            println("header")
//            let reusableView = UICollectionReusableView().
//            reusableView.backgroundColor = UIColor.cyanColor()
//        }
//        if kind == UICollectionElementKindSectionFooter {
//            println("footer")
//            reusableView.backgroundColor = UIColor.blueColor()
//        }
//        return reusableView
//    }
}
