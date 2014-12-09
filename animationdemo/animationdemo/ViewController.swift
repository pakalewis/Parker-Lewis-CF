//
//  ViewController.swift
//  animationdemo
//
//  Created by Bradley Johnson on 10/22/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        let redBox = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        redBox.backgroundColor = UIColor.redColor()
        self.view.addSubview(redBox)
    }


}

