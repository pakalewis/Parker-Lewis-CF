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
        createTiles()
        loadImagesIntoTiles()
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
    
    func swapTiles(firstTileNumber: Int, secondTileNumber: Int) {
        var tempImage = imagePiecesArray[firstTileNumber]
        imagePiecesArray[firstTileNumber] = imagePiecesArray[secondTileNumber]
        imagePiecesArray[secondTileNumber] = tempImage
        self.loadImagesIntoTiles()
    }
    
    func createTiles() {
        var dividedWidth  = self.imageToSolve.size.width / 3.0 // 100.0 -- could change with more tiles
        var dividedHeight = self.imageToSolve.size.height / 3.0 // 100.0
        for index1 in 0...2 { // go down the rows
            var posY:CGFloat = CGFloat(index1) * 100
            for index2 in 0...2 { // get the tiles in each row
                var posX:CGFloat = CGFloat(index2) * 100
                // set the boundaries of the tile
                var partialImageSquare = CGRectMake(posX, posY, dividedWidth, dividedHeight)
                // get the partial image data??
                var dataToMakeUIImage = CGImageCreateWithImageInRect(self.imageToSolve.CGImage, partialImageSquare)
                // make the new small image
                var newImage = UIImage(CGImage: dataToMakeUIImage, scale: UIScreen.mainScreen().scale, orientation: self.imageToSolve.imageOrientation)
                imagePiecesArray.append(newImage) // add the small image tile to the array
            }
        }
        
    }
    func loadImagesIntoTiles() {
        // set the tiles with the images from the pieces array
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

    //MARK: tiles tapped
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
        if firstTileSelectedBool {
            firstTileNumber = 3
            firstTileSelectedBool = false
        }
        else {
            secondTileNumber = 3
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }
    
    @IBAction func image4Tapped(sender: AnyObject) {
        if firstTileSelectedBool {
            firstTileNumber = 4
            firstTileSelectedBool = false
        }
        else {
            secondTileNumber = 4
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }
    
    @IBAction func image5Tapped(sender: AnyObject) {
        if firstTileSelectedBool {
            firstTileNumber = 5
            firstTileSelectedBool = false
        }
        else {
            secondTileNumber = 5
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }
    
    @IBAction func image6Tapped(sender: AnyObject) {
        if firstTileSelectedBool {
            firstTileNumber = 6
            firstTileSelectedBool = false
        }
        else {
            secondTileNumber = 6
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }
    
    @IBAction func image7Tapped(sender: AnyObject) {
        if firstTileSelectedBool {
            firstTileNumber = 7
            firstTileSelectedBool = false
        }
        else {
            secondTileNumber = 7
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }
    
    @IBAction func image8Tapped(sender: AnyObject) {
        if firstTileSelectedBool {
            firstTileNumber = 8
            firstTileSelectedBool = false
        }
        else {
            secondTileNumber = 8
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            firstTileSelectedBool = true
        }
    }
    
}