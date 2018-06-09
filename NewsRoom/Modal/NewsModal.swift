//
//  NewsModal.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 05/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation

struct NewsModal
{
    var author = ""
    var description = ""
    var publishedAt = ""
    var title = ""
    var url = ""
    var urlToImage = ""
    
    init(dictionary:[String:AnyObject])
    {
        author = (nullToNil(value: dictionary["author"]!))
        description = (nullToNil(value: dictionary["description"]!))
        publishedAt = (nullToNil(value: dictionary["publishedAt"]!))
        title = (nullToNil(value: dictionary["title"]!))
        url = (nullToNil(value: dictionary["url"]!))
        urlToImage = (nullToNil(value: dictionary["urlToImage"]!))

    }
    
    func nullToNil(value : AnyObject) -> String {
        if value is NSNull {
            return "No"
        } else {
            return String(describing:value)
        }
    }
}
