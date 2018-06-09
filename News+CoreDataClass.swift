//
//  News+CoreDataClass.swift
//  
//
//  Created by Vivekananda Cherukuri on 07/02/2018.
//
//

import Foundation
import CoreData

@objc(News)
public class News: NSManagedObject {
    convenience init(author:String,descriptionText:String,newsImage:NSData,publishedAt:String,title:String,context:NSManagedObjectContext)
    {
        if let ent = NSEntityDescription.entity(forEntityName: "News", in: context)
        {
            self.init(entity: ent, insertInto: context)
            
            self.author = author
            self.descriptionText = descriptionText
            self.publishedAt = publishedAt
            self.title = title
            self.newsImage = newsImage
            
        }
        else
        {
            fatalError("Unable to find Entity name!")
        }
    }
}
