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
        
        
        var buttonArray:[UIButton]
        
        var button1 = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        button1.backgroundColor = UIColor.blueColor()
        var button2 = UIButton(frame: CGRect(x: 140, y: 10, width: 100, height: 100))
        button2.backgroundColor = UIColor.blueColor()
        // this calls the function pressed()
        button1.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        button2.addTarget(self, action: "pressed1:", forControlEvents: .TouchUpInside)
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        
    }
    
    func pressed(sender: UIButton) {
        println("button1 pressed")
        self.image.image = hobbes
    }
    func pressed1(sender: UIButton) {
        println("button2 pressed")
        self.image.image = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

