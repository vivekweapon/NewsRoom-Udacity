//
//  HeadLinesViewController.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 04/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

class HeadLinesViewController: UIViewController {
    var newsCount = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var downloadedImagesArray = [UIImage]()
    let newsCellReuseIdentifier = "newsCell"
    
    @IBOutlet var headlinesTableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        headlinesTableView.rowHeight = UITableViewAutomaticDimension
        headlinesTableView.estimatedRowHeight = 150
        headlinesTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: newsCellReuseIdentifier)
        
        getNews()
        
    }
    
    func getNews() {
        
        SVProgressHUD.show()

        let service = APIService()
        service.getAllNews(search: false, searchText:nil,completion:
            ({ (NewsObject) in
                
                self.newsCount = self.appDelegate.newsModalArray.count
                
                DispatchQueue.main.async
                {
                        self.headlinesTableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }))
    }
    
}

extension HeadLinesViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.0
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.newsModalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = headlinesTableView.dequeueReusableCell(withIdentifier: newsCellReuseIdentifier, for: indexPath) as! NewsCell
        cell.titleTextView.text = self.appDelegate.newsModalArray[indexPath.row].title
        
        let imageurlString = self.appDelegate.newsModalArray[indexPath.row].urlToImage
        let url = URL(string:imageurlString)
        
        cell.newsImageView.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            
            
            if(image != nil) {
                self.appDelegate.log.debug("Image download complete..")
            }
            else {
                self.appDelegate.log.debug("Image download failed..")
                let placeHolderImage = UIImage(named: "noimage_placeholder")
                cell.newsImageView.image = placeHolderImage
                cell.activityindicatorView.stopAnimating()
            }
            
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsCell
        let image = cell.newsImageView.image
        
        let save = UITableViewRowAction(style: .default, title: "Save") { (action, indexPath) in
            
            let newsItem = self.appDelegate.newsModalArray[indexPath.row]
            BaseViewController.shared.saveInCoreDataWith(newsItem: newsItem, image: image!)
            NewsRoomAlert.shared.presentAlertView(ViewController: self, alertTitle: "NewsRoom", alertMessage: "Saved.")
        }
        
        save.backgroundColor = UIColor.green
        return [save]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsCell
        let image = cell.newsImageView.image
        
        let newsItem = self.appDelegate.newsModalArray[indexPath.row]
        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier:"newsDetailVC") as! NewsDetailViewController
        vc.newsItem = newsItem
        vc.newsItemImage = image
        
        let navController = UINavigationController(rootViewController:vc)
        present(navController, animated: true, completion: nil)
    }
    
}

