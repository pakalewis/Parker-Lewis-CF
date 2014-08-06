//
//  ViewController.swift
//  Parker-Lewis-08.06.14
//
//  Created by Parker Lewis on 8/6/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    


    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var newSwitch: UISwitch!
    @IBOutlet weak var newSlider: UISlider!

    
    @IBAction func buttonPressed(sender: UIButton) {
        println("You pressed the button!")
    }

    
//    @IBAction func buttonPressed(sender: AnyObject) {
//        println("You pressed the button!")
//    }
    
    
    @IBAction func switchToggled(sender: UISwitch) {
        println("You toggled the switch!")
    }
    
    
    
    @IBAction func sliderSlid(sender: UISlider) {
        var value: Float = newSlider.value
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

