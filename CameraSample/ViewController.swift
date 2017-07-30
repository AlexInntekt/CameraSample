//
//  ViewController.swift
//  CameraSample
//
//  Created by Manolescu Mihai Alexandru on 27/07/2017.
//  Copyright © 2017 Manolescu Mihai Alexandru. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    
    @IBOutlet weak var tableView: UITableView!

    //array that will contain the data fetched from coreData:
    var chosenSavedPictures = [PhotoProfile]()
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        populateTableViewWithPersistenData()
    }
    
    //this function is called each time this viewController pops out:
    override func viewWillAppear(_ animated: Bool)
    {
        //update the tableView with the current values:
        populateTableViewWithPersistenData()
        tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //the number of cells is equal with the number of the array's elements:
        return chosenSavedPictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //we are defining the tableView' cell:
        let cell = UITableViewCell()
        
        //extracting the image stored in coreData, convert it from binary data to UIImage, and assign it to the cell:
        cell.imageView?.image = UIImage(data: chosenSavedPictures[indexPath.row].image as! Data)
        cell.imageView?.contentMode = .scaleToFill
        
        //extracting the text from the object:
        cell.textLabel?.text = chosenSavedPictures[indexPath.row].title
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //send by segue the object that the user tapped on on the cell:
        performSegue(withIdentifier: "SegueOne", sender: chosenSavedPictures[indexPath.row])
    }
    
    
    func populateTableViewWithPersistenData()
    {
        //fetch data from coreData and assign it to the local array so that we can have easier access to it:
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do
        {
            chosenSavedPictures = try context.fetch(PhotoProfile.fetchRequest())
        }
        catch
        {
            
        }
        
        //update tableView with elements according to the local array:
        tableView.reloadData()
    }
    
    //defining the segue transfer. The obkect 'profile' from the next viewController will contain the object that we are sending by segue:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier=="SegueOne"
        {
            let nextVC = segue.destination as! CreateInstanceViewController
            nextVC.profile = sender as? PhotoProfile
        }
    }
    
    

}

