//
//  GalleryViewController.swift
//  PhotoFilters
//
//  Created by Bradley Johnson on 10/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import UIKit

protocol GalleryDelegate : class {
    func didTapOnPicture(image : UIImage)
}

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
     weak var delegate: GalleryDelegate?
//    var myParentViewController : ViewController?
//    var myProfileParentViewController : ProfileViewController
    
    var images = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self  
        
        var image1 = UIImage(named: "photo2.jpg")
        var image2 = UIImage(named: "photo3.jpg")
        var image3 = UIImage(named: "photo4.jpg")
        var image4 = UIImage(named: "photo5.jpg")
        
        self.images.append(image1)
        self.images.append(image2)
        self.images.append(image3)
        self.images.append(image4)
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GALLERY_CELL", forIndexPath: indexPath) as GalleryCell
        //cell.backgroundColor = UIColor.purpleColor()
        cell.imageView.image = self.images[indexPath.row]
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        println("indexpath: \(indexPath)")
        self.delegate?.didTapOnPicture(self.images[indexPath.row])
//self.myParentViewController?.didTapOnPicture(self.images[indexPath.row])    
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
