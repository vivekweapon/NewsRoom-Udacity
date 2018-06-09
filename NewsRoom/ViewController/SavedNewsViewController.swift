//
//  SavedNewsViewController.swift
//  NewsRoom

//  Created by Vivekananda Cherukuri on 07/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SavedNewsViewController:UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var savedNews = [News]()
    var newsModalObject:NewsModal!
    
    @IBOutlet var savedNewsTableView:UITableView!
   
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"News")
        
        do {
            let newsResults = try
            appDelegate.stack.context.fetch(fetchRequest)
            savedNews = newsResults as! [News]
        }
            
        catch let error {
            appDelegate.log.debug(error)
        }

        savedNewsTableView.reloadData()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedNewsTableView.rowHeight = UITableViewAutomaticDimension
        savedNewsTableView.estimatedRowHeight = 150
        savedNewsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")

    }
  
}

extension SavedNewsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
      
        let cell = savedNewsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        cell.titleTextView.text = savedNews[indexPath.row].title
        
        performUIUpdatesOnMain {
            cell.newsImageView.image = UIImage(data:(self.savedNews[indexPath.row].newsImage)!)
        }
        cell.activityindicatorView.stopAnimating()
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      
            if editingStyle == .delete {
                let newsItem = self.savedNews[indexPath.row]
                self.appDelegate.stack.context.delete(newsItem)
                self.appDelegate.stack.save()
            }
            
            self.savedNews.remove(at: indexPath.row)
            let indexPath = IndexPath(item: indexPath.row, section: 0)
        
            self.savedNewsTableView.deleteRows(at: [indexPath], with: .automatic)
           
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsCell
        let image = cell.newsImageView.image
        let newsItem = savedNews[indexPath.row] 
        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"newsDetailVC") as! NewsDetailViewController
        
        let newsDict = ["author":newsItem.author,"title":newsItem.title,"publishedAt":newsItem.publishedAt,"description":newsItem.descriptionText,"urlToImage":"","url":""]
        
        newsModalObject = NewsModal(dictionary:newsDict as [String : AnyObject])
    
        vc.newsItem = newsModalObject
        vc.newsItemImage = image

        let navController = UINavigationController(rootViewController:vc)
        present(navController, animated: true, completion: nil)
    }
}


