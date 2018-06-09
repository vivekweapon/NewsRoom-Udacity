//
//  BaseViewController.swift
//  
//
//  Created by Vivekananda Cherukuri on 06/02/2018.
//

import Foundation
import UIKit
import CoreData

public class BaseViewController
{
    static let shared = BaseViewController()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    //MARK:SAVE IN CORE DATA.
    func saveInCoreDataWith(newsItem:NewsModal,image:UIImage )
    {
       _ = createNewsEntityFrom(dictionary: newsItem,image: image)
        appDelegate?.stack.save()
        
    }
    
    
    //MARK:CREATE PHOTO ENTITY.
    private func createNewsEntityFrom(dictionary: NewsModal,image:UIImage) -> NSManagedObject?
    {
        
        if let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "News", into: (appDelegate?.stack.context)!) as? News {

            newsEntity.author = dictionary.author
            newsEntity.descriptionText = dictionary.description
            newsEntity.publishedAt = dictionary.publishedAt
            newsEntity.title = dictionary.title
            
            let data = UIImagePNGRepresentation(image) as NSData?
            newsEntity.newsImage = data as Data?
            
           
            return newsEntity
        }
        return nil
    }
    
}
