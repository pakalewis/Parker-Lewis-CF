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
    var currentDetailPerson = Person(firstName: "First: ", lastName: "Last: ")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         connected in storyboard
//        self.personFirstName.delegate = self
//        self.personLastName.delegate = self

        personFirstName.text = currentDetailPerson.firstName
        personLastName.text = currentDetailPerson.lastName
        if currentDetailPerson.image == nil {
            self.personImage.image = UIImage(named: "nopic")
        }
        else { self.personImage.image = currentDetailPerson.image }

//        personImage.contentMode
        
//        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func changePicture(sender: AnyObject) {
        var imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        var newPicture = info[UIImagePickerControllerOriginalImage] as UIImage
        personImage.image = newPicture
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
    }

    
    
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if ( segue.identifier == "saveChangesAndGoBack") {
//            println("segue back")
//            var backToTableView = segue.destinationViewController as ViewController
//            currentDetailPerson.firstName = personFirstName.text
//            currentDetailPerson.lastName = personLastName.text
//            backToTableView.currentPerson = self.currentDetailPerson
//            // how do I target the correct cell in the table to change the data??????
//            // do i need this button or can I use the navigation controller's "back" button
//            
//        }
//        
//    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
