//
//  Constants.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 04/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation

struct Constants
{
    struct News
    {
         static let APIScheme = "https"
         static let APIHost = "newsapi.org"
         static let APIAllNewsPath = "/v2/top-headlines"
         static let APISearchPath = "/v2/everything"
    }
    
    struct NewsParameterKeys
    {
        static let APIKey = "apiKey"
        static let Country = "country"
        static let SearchKey = "q"
    }
    
    struct NewsParameterValues
    {
        static let APIKey = "fe96a196113a4a71a4045bbc20682df5"
        static let Country = "us"
    }
}
