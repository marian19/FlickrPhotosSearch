//
//  Photo.swift
//
//
//  Created by Marian on 2/18/17.
//
//

import Foundation
import CoreData
import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage


@objc(Photo)
public class Photo: NSManagedObject {
    
    static func deleteAllPhotos()  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
            let managedObjectContext = appDelegate.managedObjectContext
        
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            _ = try managedObjectContext.execute(request)
        } catch {
            print("delete error")
        }
    }
    
    func getPhotoThumbnailURL() -> String {
        return "https://farm\(farm!).staticflickr.com/\(server!)/\(photoID!)_\(secret!)_m.jpg"
    }
    
    func getLargePhotoURL() -> String {
        return "https://farm\(farm!).staticflickr.com/\(server!)/\(photoID!)_\(secret!)_b.jpg"
    }
    
    static func createPhotoFrom(jsonDictionary : JSON) -> Photo {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedObjectContext = appDelegate?.managedObjectContext

        
        let entity = NSEntityDescription.entity(forEntityName: "Photo",
                                                in: managedObjectContext!)!
        
        let photo = NSManagedObject(entity: entity,
                                    insertInto: managedObjectContext) as! Photo
        
        photo.setValue(jsonDictionary["title"].stringValue, forKey: "title")
        photo.setValue(jsonDictionary["farm"].stringValue, forKey: "farm")
        photo.setValue(jsonDictionary["owner"].stringValue, forKey: "ownerID")
        photo.setValue(jsonDictionary["id"].stringValue, forKey:"photoID")
        photo.setValue(jsonDictionary["secret"].stringValue, forKey: "secret")
        photo.setValue(jsonDictionary["server"].stringValue, forKey: "server")
        
        Alamofire.request(photo.getPhotoThumbnailURL()).responseImage { response in
            
                        
            if let image = response.result.value {
                photo.setValue(UIImagePNGRepresentation(image), forKey: "image")
                do {
                    try managedObjectContext?.save()
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
       
        return photo
    }
    
    static func getAllPhotos() -> [Photo]{
        
        var photos  = [Photo]()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedObjectContext = appDelegate?.managedObjectContext

        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            
            try
                photos = managedObjectContext!.fetch(fetchRequest) as! [Photo]
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
       
        return photos
    }
}
