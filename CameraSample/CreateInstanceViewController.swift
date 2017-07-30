//
//  CreateInstanceViewController.swift
//  CameraSample
//
//  Created by Manolescu Mihai Alexandru on 27/07/2017.
//  Copyright © 2017 Manolescu Mihai Alexandru. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CreateInstanceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    //we use this variable for accessing camera and photo library:
    var imagePicker = UIImagePickerController()
    
    //this will contain the object sent by segue:
    var profile : PhotoProfile? = nil
    
    
    @IBOutlet weak var ShowPicture: UIImageView!
    @IBOutlet weak var titleTextfield: UITextField!
    
    //get access to camera:
    @IBAction func takePictureBT(_ sender: Any)
    {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    //get access to photo library:
    @IBAction func goToPhotos(_ sender: Any)
    {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    //if the user chose to add a new object (meaning photo to the list), this button will be called "add" and will add a new object to the list. Otherwise, it will be "update" and will edit the curent object in the list:
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButton(_ sender: Any)
    {
        
        if profile != nil
        {
            profile!.title = titleTextfield.text
            profile!.image = UIImagePNGRepresentation(ShowPicture.image!)! as NSData

        }
        else
        {
            //need to change and update members' values of the photo that was sent by segue:
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let profile = PhotoProfile(context: context)
            
            profile.title = titleTextfield.text
            
            if ShowPicture.image == nil
            {
                profile.image = UIImagePNGRepresentation(#imageLiteral(resourceName: "f"))! as NSData
            }
            else
            {
               profile.image = UIImagePNGRepresentation(ShowPicture.image!)! as NSData
            }
            
            
        }
        
        //for either case, save the data in the coreData's context:
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }

    //this button appears only when the user tapped on one of the TableView's cell, and it offers the user the possibilit to delete it from the storage:
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteButton(_ sender: Any)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(profile!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
    }
    

    //after choosing a photo from library or after shooting a picture with the camera, dissmis that viewController and come back to the proper one:
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ShowPicture.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    //dissmis the keyboard after tapping on 'return' from the textField:
    func textFieldShouldReturn(_ titleTextfield: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        imagePicker.delegate = self
        titleTextfield.delegate = self

        //set the viewController according to the fact if the user tapped on the 'plus' button previously or tapped on one of the tableView cell:
        if profile != nil
        {
            print("# Photo sent along with the segue transfer.")
            
            ShowPicture.image = UIImage(data: profile?.image as Data!)
            titleTextfield.text = profile?.title
            saveButton.setTitle("Update", for: .normal)
            
        }
        else
        {
            print("# Nothing sent this time.")
            saveButton.setTitle("Add", for: .normal)
            deleteButton.isHidden = true
        }
    }





}
