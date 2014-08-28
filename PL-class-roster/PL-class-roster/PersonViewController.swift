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
        buttonImage.setImage(currentDetailPerson.gitHubAvatar, forState: UIControlState.Normal)


        self.personImage.layer.cornerRadius = 100.0
        self.personImage.clipsToBounds = true
//        self.buttonImage.layer.cornerRadius = 30.0
//        self.buttonImage.clipsToBounds = true

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
    // click the button to change the image
    @IBAction func changePicture(sender: AnyObject) {
        // create image picker
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true

        
        
        // create alert view
        var changePhotoAlert = UIAlertController(title: "", message: "Take a new picture with the Camera or choose one from the Photo Library", preferredStyle: UIAlertControllerStyle.Alert)
        
        changePhotoAlert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler:{
            (alertAction:UIAlertAction!) in
//            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
//            self.presentViewController(imagePickerController, animated: true, completion: nil)
            
            // second alert
            var noCameraAlert = UIAlertController(title: "", message: "No camera is available on this device", preferredStyle: UIAlertControllerStyle.Alert)
            noCameraAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))

            self.presentViewController(noCameraAlert, animated: true, completion: nil)
        }))
        
        changePhotoAlert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler:{ (alertAction:UIAlertAction!) in
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }))

        
        // present the alert which has buttons for the two choices
        self.presentViewController(changePhotoAlert, animated: true, completion: nil)
        
//
//        // check if sourcetype is available
//        if UIImagePickerController.isSourceTypeAvailable(imagePickerController.sourceType) {
//            println("Camera is available on device")
//            self.presentViewController(imagePickerController, animated: true, completion: nil)
//        }
//        else {
//            self.presentViewController(noCameraAlert, animated: true, completion: nil)
//        }

//        imagePickerController.sourceType = UIImagePickerController.isSourceTypeAvailable(.Camera) ? .Camera : .PhotoLibrary
//        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        var newPicture = info[UIImagePickerControllerOriginalImage] as UIImage
        personImage.image = newPicture
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // image as a button
    @IBOutlet weak var buttonImage: UIButton!

    // the button image was pressed
    @IBAction func chooseImage(sender: AnyObject) {
        // get image from web
        var imageURL = NSURL(string: "https://avatars2.githubusercontent.com/u/8174456?v=2&s=460")
        var imageData = NSData(contentsOfURL: imageURL)
        var imageFromWeb = UIImage(data: imageData)
        buttonImage.setImage(imageFromWeb, forState: UIControlState.Normal)
        currentDetailPerson.gitHubAvatar = imageFromWeb
        
        // set button's image (eventually will get image from web)
        //        var newimage = UIImage(named: "nopic")
        //        buttonImage.setImage(newimage, forState: UIControlState.Normal)
        
        
        
        // create alert that appears when button is pressed
        var alert = UIAlertController(title: "", message: "Enter your GitHub username", preferredStyle: UIAlertControllerStyle.Alert)
        // textfield to enter GitHub username
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = self.currentDetailPerson.gitHubUserName
            textField.secureTextEntry = false
        })
        // alert button for when done entering
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (alertAction:UIAlertAction!) in
            let alertTextField = alert.textFields[0] as UITextField
            var alertTextFieldText : String!
            alertTextFieldText = alertTextField.text
            
            // save the github username the user entered
            self.currentDetailPerson.gitHubUserName = alertTextFieldText
            self.gitHubUsername.text = alertTextFieldText
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

        
    }
    
    
    
    
    
}
