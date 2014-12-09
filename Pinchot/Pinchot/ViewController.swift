//
//  ViewController.swift
//  Pinchot
//
//  Created by Andrew Shepard on 10/21/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    
    // Save starting location of animation
    var origin: CGRect?
    
    private let names = ["photo0.jpg", "photo1.jpg", "photo2.jpg", "photo3.jpg"]
    lazy var images: [UIImage] = {
        var imgs = [UIImage]()
        for name in self.names {
            imgs.append(UIImage(named: name)!)
        }
        return imgs
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myObject : AnyObject!
        
        var number = 21
        
        switch number {
        case 0:
            myObject = "hello"
        case 1:
            myObject = 12
        default:
            println("hey")
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Images"        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(280, 280)
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "ImageCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as ImageCell
        
        let image = self.images[indexPath.row % self.images.count]
        cell.imageView.image = image
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Grab the attributes of the tapped upon cell
        let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)
        
        // Grab the onscreen rectangle of the tapped upon cell, relative to the collection view
        let origin = self.view.convertRect(attributes!.frame, fromView: collectionView)
        
        // Save our starting location as the tapped upon cells frame
        self.origin = origin
        
        // Find tapped image, initialize next view controller
        let image = self.images[indexPath.row % self.images.count]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("ImageViewController") as ImageViewController
        
        // Set image and reverseOrigin properties on next view controller
        viewController.image = image
        viewController.reverseOrigin = self.origin!
        
        // Trigger a normal push animations; let navigation controller take over.
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

