//
//  ViewController.swift
//  Practice
//
//  Created by Parker Lewis on 12/23/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var counter = 1

    @IBOutlet weak var testTile: Tile!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    override func viewDidLayoutSubviews() {
    }

    
    
    
    @IBAction func testButton(sender: AnyObject) {

        
        
        // Animation calculations
        let fullRotation = CGFloat(M_PI * 2) / CGFloat(self.counter / 4)

        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.testTile.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2))
            
        })
        
        self.counter++
//        if self.counter == 4 {
//            counter = 1
//        }
        
    }
}

