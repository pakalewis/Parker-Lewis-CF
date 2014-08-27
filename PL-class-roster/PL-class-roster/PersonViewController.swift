//
//  PersonViewController.swift
//  PL-class-roster
//
//  Created by Parker Lewis on 8/11/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class PersonViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var personFirstName: UITextField!
    @IBOutlet weak var personLastName: UITextField!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var gitHubUsername: UITextField!
    var currentDetailPerson = Person(firstName: "First: ", lastName: "Last: ")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        connected in storyboard
//        self.personFirstName.delegate = self
//        self.personLastName.delegate = self

        // set image
        if currentDetailPerson.image == nil {
            self.personImage.image = UIImage(named: "nopic")
        }
        else { self.personImage.image = currentDetailPerson.image }
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // set the textField.text values from the model
        personFirstName.text = currentDetailPerson.firstName
        personLastName.text = currentDetailPerson.lastName
        gitHubUsername.text = currentDetailPerson.gitHubUserName

        self.personImage.layer.cornerRadius = 100.0
        self.personImage.clipsToBounds = true

    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // update the model from the textField.text values
        currentDetailPerson.firstName = personFirstName.text
        currentDetailPerson.lastName = personLastName.text
        currentDetailPerson.gitHubUserName = gitHubUsername.text
        currentDetailPerson.image = personImage.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//MARK: IMAGE PICKER
    @IBAction func changePicture(sender: AnyObject) {
        var imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        var noCameraAlert = UIAlertController(title: "No Cam", message: "No camera is available on this device", preferredStyle: UIAlertControllerStyle.ActionSheet)
        noCameraAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))

        // check if sourcetype is available
        if UIImagePickerController.isSourceTypeAvailable(imagePickerController.sourceType) {
            println("Camera is available on device")
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
        else {
            self.presentViewController(noCameraAlert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        var newPicture = info[UIImagePickerControllerOriginalImage] as UIImage
        personImage.image = newPicture
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
    
    
    
    
}
