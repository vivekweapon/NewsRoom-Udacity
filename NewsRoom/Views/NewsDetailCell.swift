//
//  NewsDetailCell.swift
//  NewsRoom
//
//  Created by Vivekananda Cherukuri on 07/02/2018.
//  Copyright © 2018 Flying Fish Studios. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailCell:UITableViewCell
{
    
    @IBOutlet var author:UILabel!
    @IBOutlet var publishedAt:UILabel!
    @IBOutlet var title:UILabel!
    @IBOutlet var descriptiontextView:UITextView!
    @IBOutlet var newsItemImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}
