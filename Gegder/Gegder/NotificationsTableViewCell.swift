//
//  NotificationsTableViewCell.swift
//  Gegder
//
//  Created by Yi Hao on 6/7/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DateTime: UILabel!
    @IBOutlet weak var Title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}