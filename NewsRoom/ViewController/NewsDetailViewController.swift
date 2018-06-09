//
//  NewsDetailViewController.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 06/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailViewController:UIViewController
{
    @IBOutlet var newsDetailTableView:UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var newsItemImage:UIImage!
    var newsItem:NewsModal! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneBarButtItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action:#selector(doneButtonTapped))
        
        navigationItem.rightBarButtonItem = doneBarButtItem
        
        newsDetailTableView.rowHeight = UITableViewAutomaticDimension
        newsDetailTableView.estimatedRowHeight = 500
        newsDetailTableView.register(UINib(nibName: "NewsDetailCell", bundle: nil), forCellReuseIdentifier: "newsDetailCell")
        
    }
    
    @objc func doneButtonTapped() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension NewsDetailViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 600.0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = newsDetailTableView.dequeueReusableCell(withIdentifier: "newsDetailCell", for: indexPath) as! NewsDetailCell
        cell.author.text = "Author: " + newsItem.author
        cell.title.text =  "Title: " + newsItem.title
        cell.publishedAt.text = "Published Date: " + newsItem.publishedAt
        cell.descriptiontextView.text = "Description: " + newsItem.description
        cell.newsItemImageView.image = newsItemImage
        appDelegate.log.debug(newsItem.description)
        return cell
        
    }
}
