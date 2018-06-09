//
//  NewsRoomAlertController.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 07/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation
import UIKit

public class NewsRoomAlert
{
    static let shared = NewsRoomAlert()
    
    public func presentAlertView(ViewController:UIViewController!, alertTitle:String!, alertMessage:String!)
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let Action = UIAlertAction(
        title: "OK", style: UIAlertActionStyle.default) { (action) in }
        
        alert.addAction(Action)
        ViewController.present(alert, animated: true, completion: nil)
    }
    
    public func presentAlertWithCancelAndOkButton(ViewController:UIViewController,alertTitle:String!,alertMessage:String!,alertCompletionHandler:@escaping (()->Void))
    {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "OK", style: UIAlertActionStyle.default)
        { (action) in
            alertCompletionHandler()
        }
        
        let cancelAction = UIAlertAction(title:"Cancel",style:UIAlertActionStyle.default){ (action) in }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        ViewController.present(alert, animated: true, completion: nil)
    }
    
}

