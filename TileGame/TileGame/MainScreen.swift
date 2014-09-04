//
//  MainScreen.swift
//  TileGame
//
//  Created by Parker Lewis on 9/3/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class MainScreen: UIViewController {
                            
    @IBOutlet weak var imageCycler: UIImageView!
    let image1 = UIImage(named: "image1")
    let image2 = UIImage(named: "image2")
    let image3 = UIImage(named: "image3")
    let image4 = UIImage(named: "image4")
    let image5 = UIImage(named: "image5")
    var imageArray = [UIImage]()
    var imageToSolve = UIImage()
    var currentIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray =  [image1, image2, image3, image4, image5]
        self.imageCycler.image = imageArray[currentIndex]
    }

    @IBAction func letsPlayButton(sender: AnyObject) {
        self.performSegueWithIdentifier("playGame", sender: self)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var gameScreen = segue.destinationViewController as GameScreen
        if (segue.identifier == "playGame") {
            self.imageToSolve = imageArray[currentIndex]
        }
        gameScreen.imageToSolve = self.imageToSolve
        
    }
    
    
    
    @IBAction func nextButton(sender: AnyObject) {
        currentIndex += 1
        if currentIndex == imageArray.count {
            currentIndex = 0
        }
        self.imageCycler.image = imageArray[currentIndex]
    }

    @IBAction func previousButton(sender: AnyObject) {
        println("previous button pressed - currentIndex = \(currentIndex)")
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = imageArray.count - 1
        }
        self.imageCycler.image = imageArray[currentIndex]
    }

}