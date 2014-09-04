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
    
    var imageToSolve = UIImage()
    let image4 = UIImage(named: "image4") // this is temporary for imageToSolve
    var firstTileSelectedBool = true
    var firstTileNumber = 0
    var secondTileNumber = 0
    
    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    
    var imagePiecesArray = [UIImage]()
    
    override func viewDidLoad() {
        loadImagesIntoViews()
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
        var tempImage = imagePiecesArray[firstTileNumber]
        imagePiecesArray[firstTileNumber] = imagePiecesArray[secondTileNumber]
        imagePiecesArray[secondTileNumber] = tempImage
        self.loadImagesIntoViews()
    }
    
    func loadImagesIntoViews() {
        var dividedWidth  = image4.size.width / 3.0 // 100.0
        var dividedHeight = image4.size.height / 3.0 // 100.0
        for index1 in 0...2 {
            var posY:CGFloat = CGFloat(index1) * 100
            for index2 in 0...2 {
                var posX:CGFloat = CGFloat(index2) * 100
                // set the boundaries of the square
                var partialImageSquare = CGRectMake(posX, posY, dividedWidth, dividedHeight)
                println()
                // get the partial image data
                var dataToMakeUIImage = CGImageCreateWithImageInRect(image4.CGImage, partialImageSquare)
                // make the new small image
                var newImage = UIImage(CGImage: dataToMakeUIImage, scale: UIScreen.mainScreen().scale, orientation: image4.imageOrientation)
                imagePiecesArray.append(newImage)
            }
        }
        
        imageView0.image = imagePiecesArray[0]
        imageView1.image = imagePiecesArray[1]
        imageView2.image = imagePiecesArray[2]
        imageView3.image = imagePiecesArray[3]
        imageView4.image = imagePiecesArray[4]
        imageView5.image = imagePiecesArray[5]
        imageView6.image = imagePiecesArray[6]
        imageView7.image = imagePiecesArray[7]
        imageView8.image = imagePiecesArray[8]
    }
}