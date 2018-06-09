//
//  NewsItem+CoreDataProperties.swift
//  
//
//  Created by Vivekananda Cherukuri on 06/02/2018.
//
//

import Foundation
import CoreData


extension NewsItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsItem> {
        return NSFetchRequest<NewsItem>(entityName: "NewsItem")
    }

    @NSManaged public var author: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var newsImage: NSData?
    @NSManaged public var title: String?

}
