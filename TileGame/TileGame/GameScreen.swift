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
    var imagePiecesArray = [UIImage]()
    var correctArray = [UIImage]()
    var tileButtonArray = [UIButton]()

    
    @IBOutlet weak var tileArea: UIView!
    @IBOutlet weak var congratsMessage: UILabel!
    
    
    override func viewDidLoad() {
        createImagePieces(3) // pass the number in from MainScreen
        shuffleTiles()

        // testing animation
        UIView.animateWithDuration(1.5, delay: 0.0, options: nil, animations: {
            var frame = self.tileButtonArray[0].frame
            frame.origin.x += 50
            frame.origin.y += 50
            self.self.tileButtonArray[0].frame = frame
            }, completion: nil)

        congratsMessage.text = "Keep going..."
    }
    
    
    
    // cuts up the main image into pieces and stores them in an array
    // at the same time, create buttons with the same dimensions and also put in an array
    // load the pictures
    func createImagePieces(size:Int) {
        var margin:CGFloat = 5.0
        println(self.tileArea.frame.width)
        var tileSideLength:CGFloat  = (self.tileArea.frame.width - (margin * CGFloat(size-1))) / CGFloat(size)
        println(tileSideLength)
        for index1 in 0..<size { // go down the rows
            var posY:CGFloat = CGFloat(index1) * (tileSideLength + margin)
            for index2 in 0..<size { // get the tiles in each row
                var posX:CGFloat = CGFloat(index2) * (tileSideLength + margin)
                // set the boundaries of the tile
                println("x = \(posX) and y = \(posY)")
                var tileFrame = CGRectMake(posX, posY, tileSideLength, tileSideLength)
                var bigTileFrame = CGRectMake(posX, posY, tileSideLength, tileSideLength)
                // get the partial image data from the main image??
                var dataToMakeUIImage = CGImageCreateWithImageInRect(self.imageToSolve.CGImage, tileFrame)
                // make the new small image
                var imagePiece = UIImage(CGImage: dataToMakeUIImage, scale: UIScreen.mainScreen().scale, orientation: self.imageToSolve.imageOrientation)
                self.imagePiecesArray.append(imagePiece) // add the small image tile to the array

                // make button and put in array
                var button = UIButton(frame: tileFrame)
                button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
                self.tileArea.addSubview(button)
                self.tileButtonArray.append(button)

            }
        }
        // save the initial order to check against later
        self.correctArray = self.imagePiecesArray
    }
    
    
    // one of the buttons was pressed
    // get the index from the array and then set some properties depending if it was the first or second button pressed
    func buttonPressed(sender: UIButton) {
        var index = find(self.tileButtonArray, sender)
        if self.firstTileSelectedBool { // this is the first tile pressed
            self.firstTileNumber = index!
            self.firstTileSelectedBool = false
        }
        else {
            self.secondTileNumber = index!
            self.swapTiles(firstTileNumber, secondTileNumber: secondTileNumber)
            self.firstTileSelectedBool = true
        }
    }

    
    // swaps the images in the array
    func swapTiles(firstTileNumber: Int, secondTileNumber: Int) {
        var tempImage = imagePiecesArray[firstTileNumber]
        imagePiecesArray[firstTileNumber] = imagePiecesArray[secondTileNumber]
        imagePiecesArray[secondTileNumber] = tempImage
        
        // reload images into buttons
        self.loadImagesIntoButtons()

        // if the order is now correct, the user wins!
        if checkTileOrder() {
            congratsMessage.backgroundColor = UIColor.cyanColor()
            congratsMessage.text = "Congratulations!"
        }
    }

    
    // this shuffles the image pieces in the array
    func shuffleTiles() {
        for var index = imagePiecesArray.count - 1; index > 0; index-- {
            // Random int from 0 to index-1
            var j = Int(arc4random_uniform(UInt32(index-1)))
            
            var tempImage = imagePiecesArray[j]
            imagePiecesArray[j] = imagePiecesArray[index]
            imagePiecesArray[index] = tempImage
        }
        self.loadImagesIntoButtons()
    }

    
    // iterates through the images array and sets button images
    func loadImagesIntoButtons() {
        // set the tiles with the images from the pieces array
        for var index = 0; index < imagePiecesArray.count; index++ {
            var image = imagePiecesArray[index]
            self.tileButtonArray[index].setImage(image, forState: .Normal)
        }
    }

    
    // checks to see if the image pieces are in the correct order
    func checkTileOrder() -> Bool {
        for index in 0...8 {
            if imagePiecesArray[index] != correctArray[index] {
                return false
            }
        }
        return true
    }


    @IBAction func backToMainScreen(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}