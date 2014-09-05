//
//  ViewController.swift
//  practice
//
//  Created by Parker Lewis on 9/4/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var image:UIImageView!
    let hobbes = UIImage(named: "hobbes")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.backgroundColor = UIColor.blueColor()
        UIView.animateWithDuration(2.5, delay: 0.0, options: nil, animations: {
            var frame = self.image.frame
            frame.origin.x += 50
            frame.origin.y += 50
            self.image.frame = frame
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

