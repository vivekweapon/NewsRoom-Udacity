//
//  SearchNewsController.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 06/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Kingfisher



class SearchNewsController:UIViewController,UISearchBarDelegate {
    
    @IBOutlet var searchNewsTableView:UITableView!
    @IBOutlet var newsSearchBar:UISearchBar!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var newsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchNewsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if(searchBar.text == "") {
            NewsRoomAlert.shared.presentAlertView(ViewController: self, alertTitle: "NewsRoom", alertMessage: "Enter Search Text.")
        }
        else {
            SVProgressHUD.show()
            let service = APIService()
            
            appDelegate.searchnewsModalArray.removeAll()
            service.getAllNews(search: true,searchText:searchBar.text!) { (NewsObject) in
                
                self.newsCount = self.appDelegate.searchnewsModalArray.count
                
                if(self.newsCount == 0) {
                    NewsRoomAlert.shared.presentAlertView(ViewController: self, alertTitle: "NewsRoom", alertMessage: "No Results Found.")
                }
                
                DispatchQueue.main.async {
                    
                    self.searchNewsTableView.reloadData()
                        
                }
                SVProgressHUD.dismiss()
            }
        }
        searchBar.resignFirstResponder()
    }
}

extension SearchNewsController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.0
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.searchnewsModalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchNewsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        
        cell.titleTextView.text = self.appDelegate.searchnewsModalArray[indexPath.row].title
        
        let imageurlString = self.appDelegate.searchnewsModalArray[indexPath.row].urlToImage
        
        let url = URL(string:imageurlString)
        
        cell.newsImageView.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            
            if(image != nil)
            {
                self.appDelegate.log.debug("Image nil returned.")
            }
            else
            {
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
            
            let newsItem = self.appDelegate.searchnewsModalArray[indexPath.row]
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
        
        let newsItem = self.appDelegate.searchnewsModalArray[indexPath.row]
        
        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"newsDetailVC") as! NewsDetailViewController
        vc.newsItem = newsItem
        vc.newsItemImage = image
        
        let navController = UINavigationController(rootViewController:vc)
        present(navController, animated: true, completion: nil)
    }
}


