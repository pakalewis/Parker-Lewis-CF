//
//  GameScreen.swift
//  TileGame
//
//  Created by Parker Lewis on 9/3/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class GameScreen: UIViewController {
    
    var firstTileSelectedBool = true
    var firstTileNumber = 0
    var secondTileNumber = 0
    
    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    let image1 = UIImage(named: "image1")
    let image2 = UIImage(named: "image2")
    let image3 = UIImage(named: "image3")
    let image4 = UIImage(named: "image4")
    var imageViewArray = [UIImageView]()
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        imageViewArray = [imageView0, imageView1, imageView2, imageView3]
        imageArray = [image1, image2, image3, image4]
        self.loadImagesIntoViews()
    }
    
    @IBAction func image0Tapped(sender: AnyObject) {
        println("image 0 tapped")
        if firstTileSelectedBool {
            // this is the first tile selected
            firstTileNumber = 0
            firstTileSelectedBool = false
        }
        else {
            // this is the second tile selected
            secondTileNumber = 0
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }
    
    @IBAction func image1Tapped(sender: AnyObject) {
        println("image 1 tapped")
        if firstTileSelectedBool {
            // this is the first tile selected
            firstTileNumber = 1
            firstTileSelectedBool = false
        }
        else {
            // this is the second tile selected
            secondTileNumber = 1
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }

    @IBAction func image2Tapped(sender: AnyObject) {
        println("image 2 tapped")
        if firstTileSelectedBool {
            // this is the first tile selected
            firstTileNumber = 2
            firstTileSelectedBool = false
        }
        else {
            // this is the second tile selected
            secondTileNumber = 2
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }

    @IBAction func image3Tapped(sender: AnyObject) {
        println("image 3 tapped")
        if firstTileSelectedBool {
            // this is the first tile selected
            firstTileNumber = 3
            firstTileSelectedBool = false
        }
        else {
            // this is the second tile selected
            secondTileNumber = 3
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }
    
    func swapTiles(firstTileNumber: Int, secondTileNumber: Int) {
        var tempImage = imageArray[firstTileNumber]
        imageArray[firstTileNumber] = imageArray[secondTileNumber]
        imageArray[secondTileNumber] = tempImage
        self.loadImagesIntoViews()
    }
    
    func loadImagesIntoViews() {
        imageViewArray[0].image = imageArray[0]
        imageViewArray[1].image = imageArray[1]
        imageViewArray[2].image = imageArray[2]
        imageViewArray[3].image = imageArray[3]
    }
}