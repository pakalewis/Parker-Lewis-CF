//
//  GalleryVC.swift
//  PhotoFilters
//
//  Created by Parker Lewis on 10/13/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

protocol GalleryDelegate : class {
    func didSelectPicture(image: UIImage)
}

class GalleryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    var galleryHeader : GalleryHeader?
    var imageArray = [UIImage]()
    weak var delegate : GalleryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        var image1 = UIImage(named: "1.jpg")
        var image2 = UIImage(named: "2.jpg")
        var image3 = UIImage(named: "3.jpg")
        var image4 = UIImage(named: "4.jpg")
        var image5 = UIImage(named: "5.jpg")
        var image6 = UIImage(named: "6.jpg")
        var image7 = UIImage(named: "7.jpg")
        var image8 = UIImage(named: "8.jpg")
        var image9 = UIImage(named: "9.jpg")
        var image10 = UIImage(named: "10.jpg")
        var image11 = UIImage(named: "11.jpg")
        
        self.imageArray.append(image1)
        self.imageArray.append(image2)
        self.imageArray.append(image3)
        self.imageArray.append(image4)
        self.imageArray.append(image5)
        self.imageArray.append(image6)
        self.imageArray.append(image7)
        self.imageArray.append(image8)
        self.imageArray.append(image9)
        self.imageArray.append(image10)
        self.imageArray.append(image11)
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GALLERY_CELL", forIndexPath: indexPath) as GalleryCell
        cell.imageView!.image = self.imageArray[indexPath.row]
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // pass the selected image back to the main VC
        self.delegate?.didSelectPicture(self.imageArray[indexPath.row])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // set up header and footer views
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {

        if kind == UICollectionElementKindSectionHeader {
            println("header")
            let reusableView : GalleryHeader = galleryCollectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "GALLERY_HEADER", forIndexPath: indexPath) as GalleryHeader
            reusableView.headerLabel.text = "Images from unsplash.com"
            return reusableView
        }
        else {
            println("footer")
            let reusableView : GalleryFooter = galleryCollectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "GALLERY_FOOTER", forIndexPath: indexPath) as GalleryFooter
            reusableView.footerLabel.text = "\(self.imageArray.count) images available"
            return reusableView
        }

    }
    
}
