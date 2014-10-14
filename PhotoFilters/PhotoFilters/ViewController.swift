//
//  ViewController.swift
//  PhotoFilters
//
//  Created by Parker Lewis on 10/13/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GalleryDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var filteredImagesCollection: UICollectionView!
    var mainImage = UIImage(named: "default_image")

    // constraint outlets
    @IBOutlet weak var mainImageViewLeading: NSLayoutConstraint!
    @IBOutlet weak var mainImageViewBottom: NSLayoutConstraint!
    @IBOutlet weak var mainImageViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var filterCollectionBottom: NSLayoutConstraint!
    
    
    // dog and leash???
//    var galleryVC = GalleryVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainImageView.image = self.mainImage
        
        self.filteredImagesCollection.delegate = self
        self.filteredImagesCollection.dataSource = self
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SHOW_GALLERY" {
            let destinationVC = segue.destinationViewController as GalleryVC
            destinationVC.delegate = self
        }
    }

    @IBAction func myButton(sender: AnyObject) {
        // create alert view
        let alertController = UIAlertController(title: nil, message: "Choose photo from:", preferredStyle: UIAlertControllerStyle.ActionSheet)

        // create buttons for the various alert actions
        let galleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.performSegueWithIdentifier("SHOW_GALLERY", sender: self)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        let filterAction = UIAlertAction(title: "Filter", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.morphToFilterMode()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
        }
        alertController.addAction(galleryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(filterAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var imagePicked = info[UIImagePickerControllerEditedImage] as? UIImage
        self.mainImage = imagePicked!
        self.mainImageView.image = self.mainImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func didSelectPicture(image : UIImage) {
        self.mainImage = image
        self.mainImageView.image = self.mainImage
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.filteredImagesCollection.dequeueReusableCellWithReuseIdentifier("filteredImageCell", forIndexPath: indexPath) as FilterCell
        cell.imageView.image = self.mainImage
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func morphToFilterMode() {
        //            self.mainImageViewLeading = self.mainImageViewLeading * 3
        self.mainImageViewBottom.constant = self.mainImageViewBottom.constant * 3
        self.filterCollectionBottom.constant = 100
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
}

