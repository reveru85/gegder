//
//  CommentsTableViewCell.swift
//  Gegder
//
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var Comment: UILabel!
    @IBOutlet weak var CommentDatetime: UILabel!
    @IBOutlet weak var UserLabel: UILabel!
    
    var entry : CommentData.CommentEntry!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func FlagButtonTouch(sender: UIButton) {
        
        println("Flag comment")
        
    }
}

