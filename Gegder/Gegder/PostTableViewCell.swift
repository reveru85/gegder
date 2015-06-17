//
//  PostTableViewCell.swift
//  Gegder
//
//  Created by Yi Hao on 15/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var UserLocation: UILabel!
    @IBOutlet weak var PostImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}