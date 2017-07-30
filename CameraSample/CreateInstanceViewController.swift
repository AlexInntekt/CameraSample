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

class CreateInstanceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var imagePicker = UIImagePickerController()
    
    
    @IBAction func takePictureBT(_ sender: Any)
    {
        
    }
    
    @IBAction func goToPhotos(_ sender: Any)
    {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func saveButton(_ sender: Any)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let profile = PhotoProfile(context: context)
        
        profile.title = titleTextfield.text
        profile.image = UIImagePNGRepresentation(ShowPicture.image!)! as NSData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        
        navigationController!.popViewController(animated: true)
    }

    
    
    @IBOutlet weak var ShowPicture: UIImageView!
    
    
    @IBOutlet weak var titleTextfield: UITextField!
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ShowPicture.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        imagePicker.delegate = self
    }





}
