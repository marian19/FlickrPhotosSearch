//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Marian on 2/18/17.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }
    
    @NSManaged public var title: String?
    @NSManaged public var farm: String?
    @NSManaged public var ownerID: String?
    @NSManaged public var photoID: String?
    @NSManaged public var secret: String?
    @NSManaged public var server: String?

}
