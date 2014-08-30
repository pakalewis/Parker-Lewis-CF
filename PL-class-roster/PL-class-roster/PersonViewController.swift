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
    @IBOutlet weak var buttonImage: UIButton!
    

    var currentDetailPerson = Person()
    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
        // set the five item values from the model (currentDetailPerson)
        self.personFirstName.text = currentDetailPerson.firstName
        self.personLastName.text = currentDetailPerson.lastName
        if currentDetailPerson.image == nil {
            self.personImage.image = UIImage(named: "nopic")
        }
        else {
            self.personImage.image = currentDetailPerson.image
            println("personImage set with currentDetailPerson.image")
        }
        self.gitHubUsername.text = currentDetailPerson.gitHubUserName
        self.buttonImage.setImage(currentDetailPerson.gitHubAvatar, forState: UIControlState.Normal)
        
        //button  and image aesthetics
        self.personImage.layer.cornerRadius = 100.0
        self.personImage.clipsToBounds = true
        self.buttonImage.layer.cornerRadius = 30.0
        self.buttonImage.clipsToBounds = true
//        var adjustsImageWhenHighlighted: true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //        connected in storyboard
        //        self.personFirstName.delegate = self
        //        self.personLastName.delegate = self
        
        println("view did load")
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // update the model (currentDetailPerson) from the five item values
        currentDetailPerson.firstName = personFirstName.text
        currentDetailPerson.lastName = personLastName.text
        currentDetailPerson.image = personImage.image
        currentDetailPerson.gitHubUserName = gitHubUsername.text
        currentDetailPerson.gitHubAvatar = buttonImage.imageForState(.Normal)
    }

    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
//MARK: IMAGE PICKER
    // click the button to choose an image from the camera or photo library
    @IBAction func changePicture(sender: AnyObject) {
        // create image picker
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        // create alert view
        var changePhotoAlert = UIAlertController(title: "", message: "Take a new picture with the Camera or choose one from the Photo Library", preferredStyle: UIAlertControllerStyle.Alert)
        // button to choose camera
        changePhotoAlert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler:{
            (alertAction:UIAlertAction!) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imagePickerController, animated: true, completion: nil)
            }
            else {
                var noCameraAlert = UIAlertController(title: "", message: "No camera is available on this device", preferredStyle: UIAlertControllerStyle.Alert)
                noCameraAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler:{ (alertAction:UIAlertAction!) in
                    self.presentViewController(changePhotoAlert, animated: true, completion: nil)
                    }))
                self.presentViewController(noCameraAlert, animated: true, completion: nil)
            }
        }))
        // button to choose photo library
        changePhotoAlert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler:{ (alertAction:UIAlertAction!) in
            imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }))
        // button to cancel
        changePhotoAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        // present the alert which has buttons for the two choices
        self.presentViewController(changePhotoAlert, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        var newPicture = info[UIImagePickerControllerEditedImage] as UIImage
        currentDetailPerson.image = newPicture
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    // the github button image was pressed
    @IBAction func chooseImage(sender: AnyObject) {
        // get image from web
        
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
            var alertTextFieldText = alertTextField.text
            
            // save the github username the user entered
            self.currentDetailPerson.gitHubUserName = alertTextFieldText
            self.gitHubUsername.text = alertTextFieldText
            // download avatar from github and set as the button image
            if self.currentDetailPerson.gitHubUserName != nil {
                self.getGitHubAvatar(self.currentDetailPerson.gitHubUserName!)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

        
    }

    
    
    
    // DL avatar from github
    func getGitHubAvatar(userName: String) {
        let githubURL = NSURL(string: "https://api.github.com/users/\(userName)")
        var profilePhotoURL = NSURL()
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(githubURL, completionHandler: { (data, response, error) -> Void in
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            if let avatarURL = jsonResult["avatar_url"] as? String {
                profilePhotoURL = NSURL(string: avatarURL)
            }
            var profilePhotoData = NSData(contentsOfURL: profilePhotoURL)
            var profilePhotoImage = UIImage(data: profilePhotoData)
            self.currentDetailPerson.gitHubAvatar = profilePhotoImage as UIImage
            self.viewWillAppear(true)
            self.viewDidLoad()
        })
        task.resume()
    }
    
    
}
