//
//  HeadLinesViewController.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 04/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import UIKit
import SVProgressHUD


class HeadLinesViewController: UIViewController
{
    var newsCount = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var headlinesTableView:UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
          headlinesTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        
        
        SVProgressHUD.show()
        let service = APIService()
        service.getAllNews
        { (NewsObject) in
            self.newsCount = self.appDelegate.newsModalArray.count
            print(self.newsCount)
          SVProgressHUD.dismiss()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HeadLinesViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 150.0
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return appDelegate.newsModalArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.appDelegate.newsModalArray[indexPath.row].title
        return cell
    }
    
    
}

