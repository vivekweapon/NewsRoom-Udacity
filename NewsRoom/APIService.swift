//
//  APIService.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 05/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation
import UIKit

enum Response<T> {
    case Success(T)
    case Error(String)
}

class APIService:NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var parameters:[String:String]!
    
    func getAllNews(search:Bool,searchText:String!,completion: @escaping(Response<[NewsModal]>) ->Void) {
        
        if(search == true) {
            parameters = [Constants.NewsParameterKeys.SearchKey:searchText,"sortBy":"popularity" ,Constants.NewsParameterKeys.APIKey:Constants.NewsParameterValues.APIKey] as [String:String]
        }
        else {
            parameters = [Constants.NewsParameterKeys.Country:Constants.NewsParameterValues.Country,Constants.NewsParameterKeys.APIKey:Constants.NewsParameterValues.APIKey] as [String:String]
        }
        
        let urlString = APIService.escapedParameters(parameters: parameters as [String:String])
        
        guard let url = URL(string:urlString)
            else {
            return completion(Response.Error("Invalid URL."))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard  error == nil
                else {
                return completion(Response.Error((error?.localizedDescription)!))
            }
            
            guard let data = data
                else {
                return completion(Response.Error((error?.localizedDescription)!))
            }
            
            var parsedResult:AnyObject! = nil
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                
                let parsedDict = parsedResult["articles"] as! [[String:AnyObject]]
                
                
                for news in parsedDict {
                    let newsModal = NewsModal(dictionary:news)
                    
                    if(search == true)
                    {
                        self.appDelegate.searchnewsModalArray.append(newsModal)
                    }
                    else
                    {
                        self.appDelegate.newsModalArray.append(newsModal)
                    }
                }
                
                if(search == false) {
                  
                    return completion(Response.Success(self.appDelegate.newsModalArray))
                }
                else {
                    return completion(Response.Success(self.appDelegate.searchnewsModalArray))
                }
                
                
            }
            catch let error {
                
                completion(Response.Error(error.localizedDescription))
                
            }
            }.resume()
        
    }
    
    class func escapedParameters(parameters: [String : String]) -> String {
        
        var components = URLComponents()
        components.scheme = Constants.News.APIScheme
        components.host = Constants.News.APIHost
        components.path = Constants.News.APIAllNewsPath
        
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            
            if(key != "" || value  != "") {
                let queryItem = URLQueryItem(name: key, value: value)
                components.queryItems!.append(queryItem)
            }
        }
        return  (components.url?.absoluteString)!
    }
}

