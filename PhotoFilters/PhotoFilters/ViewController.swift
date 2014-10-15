//
//  ViewController.swift
//  PhotoFilters
//
//  Created by Parker Lewis on 10/13/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import CoreData
import CoreImage
import OpenGLES

class ViewController: UIViewController, GalleryDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var filteredImagesCollection: UICollectionView!
    var mainImage = UIImage(named: "default_image")
    var mainThumbnail : UIImage?
    var filters = [Filter]()
    var thumbnailsWithFilters : [ThumbnailToFilter]?
    var context : CIContext?
    

    // constraint outlets
    @IBOutlet weak var mainImageViewLeading: NSLayoutConstraint!
    @IBOutlet weak var mainImageViewBottom: NSLayoutConstraint!
    @IBOutlet weak var mainImageViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var filterCollectionBottom: NSLayoutConstraint!
    
    
    // dog and leash???
//    var galleryVC = GalleryVC()
    
    
    override func viewWillAppear(animated: Bool) {
        // load default image
        self.mainImageView.image = self.mainImage
        
        // make thumbnail
        self.makeThumbnail()
        
        // create array of thumbnails coupled with filters
        self.setUpThumbnailsWithFiltersArray()

        // refresh collection view of the filtered thumbnails
        self.filteredImagesCollection.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set up for Collection View
        self.filteredImagesCollection.delegate = self
        self.filteredImagesCollection.dataSource = self
        
        
        // set up core data storage
        // talk to the appDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        // grab its MOC (where all the Filter entities are made)
        let managedObjectContext = appDelegate.managedObjectContext!
        // create a Seeder Object
        let seeder = CoreDataSeeder(context: managedObjectContext)
        // check if there are Filter objects already in Core Data
        var fetchRequest = NSFetchRequest(entityName: "Filter")
        var fetchResult = managedObjectContext.executeFetchRequest(fetchRequest, error: nil)
        if fetchResult?.count == 0 { // there are no "Filter" objects saved in Core Data yet
            println("creating Filter objects and saving to Core Data")
            // call the Seeder's func that creates the Filter Entities and saves the MOC
            seeder.seedCoreData()
        } else {
            println("Filter objects are already saved to Core Data")
            // populate array with the fetch result
            self.filters = fetchResult as [Filter]
        }
    }
    
    
    
    
    
    

    
    func setUpThumbnailsWithFiltersArray() {
        var ThumbnailsToFilter = [ThumbnailToFilter]()
        for filter in self.filters {
            ThumbnailsToFilter.append(ThumbnailToFilter(thumb: self.mainThumbnail!, name: filter.name))
        }
        self.thumbnailsWithFilters = ThumbnailsToFilter
    }
    

    
    
    
    
    
    
    
    
    
    
    
    func makeThumbnail() {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContext(size)
        self.mainImage.drawInRect(CGRect(x: 0, y: 0, width: 100, height: 100))
        self.mainThumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
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

        // WHAT IS WRONG WITH THIS???
        let thumbnailToFilter = self.thumbnailsWithFilters![indexPath.row]
        if thumbnailToFilter.filteredThumbnail != nil {
            cell.imageView.image = thumbnailToFilter.filteredThumbnail
        } else {
            // apply filter to thumb
            cell.imageView.image = thumbnailToFilter.originalThumbnail
            thumbnailToFilter.applyFilter({ (image) -> Void in
                cell.imageView.image = image
            })
            
        }
//        cell.imageView.image = self.thumbnails![indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // the order of the filters is not the same as in CoreDataSeeder
        // get the name of the filter and apply to the main image
        var filterName = filters[indexPath.row].name
        println("applying this filter to main image: \(filterName)")
        self.applyFilterToMainImage(filterName)
    }
    
    
    func morphToFilterMode() {
        self.mainImageViewBottom.constant = self.mainImageViewBottom.constant * 2.5
        self.filterCollectionBottom.constant = 100
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "exitFilterMode")
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func exitFilterMode() {
        self.mainImageViewBottom.constant = self.mainImageViewBottom.constant / 2.5
        self.filterCollectionBottom.constant = -100
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        self.navigationItem.rightBarButtonItem = nil
    }
    
    
    

    func applyFilterToMainImage(filterName : String) {
        var filteredImage : UIImage?
        var newQueue = NSOperationQueue()
        newQueue.addOperationWithBlock { () -> Void in
            var options = [kCIContextWorkingColorSpace : NSNull()]
            var myEAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            var gpuContext = CIContext(EAGLContext: myEAGLContext, options: options)
            var ciImage = CIImage(image: self.mainImage)
            var imageFilter = CIFilter(name: filterName)
            imageFilter.setDefaults()
            imageFilter.setValue(ciImage, forKey: kCIInputImageKey)
            var result = imageFilter.valueForKey(kCIOutputImageKey) as CIImage
            var extent = result.extent()
            var imageRef = gpuContext.createCGImage(result, fromRect: extent)
            filteredImage = UIImage(CGImage: imageRef)
            self.mainImage = filteredImage!

            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.mainImageView.image = self.mainImage
            })
        }
    }
    
}

