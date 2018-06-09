//
//  NewsCell.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 06/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation
import UIKit

class NewsCell:UITableViewCell
{
    @IBOutlet var newsImageView:UIImageView!
    @IBOutlet var titleTextView:UITextView!
    @IBOutlet var activityindicatorView:UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if(newsImageView.image == nil) {
            activityindicatorView.startAnimating()
            newsImageView.image = UIImage(named:"noimage_placeholder")
        }
        
    }
}
