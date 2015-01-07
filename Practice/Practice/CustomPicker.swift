//
//  CustomPicker.swift
//  Practice
//
//  Created by Parker Lewis on 12/23/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit

class CustomPicker: UIView {

    
    var view: UIView!
    var currentValue = 3

    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!

    
    

    override init(frame: CGRect) {
        super.init(frame: frame)

     }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    func initialize() {
        self.view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        self.view.frame = self.bounds
        
        // Make the view stretch with containing view
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)

        
        
    }

    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CustomPicker", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        return view
    }
    
    
    
    
    @IBAction func upButtonPressed(sender: AnyObject) {
        println("up")
        self.currentValue++
        println("current value = \(self.currentValue)")
        self.valueLabel.text = "\(self.currentValue)"
    }
    
    @IBAction func downButtonPressed(sender: AnyObject) {
        println("down")
        self.currentValue--
        println("current value = \(self.currentValue)")
        self.valueLabel.text = "\(self.currentValue)"
    }
    
}
