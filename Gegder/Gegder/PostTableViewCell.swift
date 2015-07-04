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
    @IBOutlet weak var PostDateTime: UILabel!
    @IBOutlet weak var PostHashtags: UILabel!
    @IBOutlet weak var PostCommentButton: UIButton!
    @IBOutlet weak var PostCommentCount: UILabel!
    @IBOutlet weak var PostLikeButton: UIButton!
    @IBOutlet weak var PostLikeCount: UILabel!
    @IBOutlet weak var PostDislikeButton: UIButton!
    @IBOutlet weak var PostDislikeCount: UILabel!
    var PostId: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func PostLikeButtonTouch(sender: UIButton) {
        //Check if action is valid
        //Post "like" to server
        //Update image
        println("like button pressed")
    }
    
    @IBAction func PostDislikeButtonTouch(sender: UIButton) {
        //Check if action is valid
        //Post "like" to server
        //Update image
        println("dislike button pressed")
    }
}
