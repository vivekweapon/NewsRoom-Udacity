//
//  News+CoreDataProperties.swift
//  
//
//  Created by Vivekananda Cherukuri on 07/02/2018.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var author: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var newsImage: NSData?
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?

}
