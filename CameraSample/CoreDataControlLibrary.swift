//
//  CoreDataControlLibrary.swift
//  CameraSample
//
//  Created by Manolescu Mihai Alexandru on 29/07/2017.
//  Copyright © 2017 Manolescu Mihai Alexandru. All rights reserved.
//
/*


import Foundation
import CoreData
import UIKit


//local data:
var photosArray = [lPhotoProfile]()

class lPhotoProfile
{
    var date = Date()
    var title = String()
    var image = UIImage()
}




// MARK: Save data
func saveData(date date: Date, title: String, image image: UIImage) -> Void
{
    let managedObjectContext = context
    let instance = NSEntityDescription.insertNewObject(forEntityName: "PhotoProfile", into: managedObjectContext) as! PhotoProfile
    instance.date = date as NSDate
    instance.title = title
        
    
    do {
        try managedObjectContext.save()
        print("saved!")
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
        
    }
    
}

// MARK: Fetching Data
func fetchData() -> Void {
    
    let moc = context
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoProfile")
    
    do {
        let fetchedInstance = try moc.fetch(fetchRequest) as! [PhotoProfile]
        
        print(fetchedInstance.count)
        for object in fetchedInstance {
            print(object.title!)
        }
        
    } catch {
        fatalError("Failed to fetch employees: \(error)")
    }
    
}



// MARK: Delete Data Records

func deleteRecords() -> Void {
    let moc = context
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoProfile")
    
    let result = try? moc.fetch(fetchRequest)
    let resultData = result as! [PhotoProfile]
    
    for object in resultData {
        moc.delete(object)
    }
    
    do {
        try moc.save()
        print("saved!")
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
        
    }
    
}

/* // MARK: Update Data
func updateRecords() -> Void {
    let moc = context
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoProfile")
    
    let result = try? moc.fetch(fetchRequest)
    
    let resultData = result as! [PhotoProfile]
    for object in resultData {
        object.name! = "\(object.name!) Joshi"
        print(object.name!)
    }
    do{
        try moc.save()
        print("saved")
    }catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")
    }
 
    
}  */
 
 
 
 */
