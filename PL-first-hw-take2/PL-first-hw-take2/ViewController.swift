//
//  ViewController.swift
//  PL-first-hw-take2
//
//  Created by Parker Lewis on 8/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var theSwitch: UISwitch!
    @IBOutlet weak var theSlider: UISlider!
    
    
    
    @IBAction func theButtonPressed(sender: AnyObject) {
        println("You pressed the button!")
    }
    

    
    @IBAction func theSwitchToggled(sender: AnyObject) {
        println("You toggled the switch!")
    }

    
    
    @IBAction func theSliderSlid(sender: AnyObject) {
        var value: Float = theSlider.value
        if value > 0.5 {
            println("The slider value is \(value)")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

