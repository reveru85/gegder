//
//  PostTableViewCell.swift
//  Gegder
//
//  Created by Yi Hao on 15/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var PostTitle: UILabel!
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
    var parentView: UIViewController!
    
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
    }
    
    @IBAction func PostDislikeButtonTouch(sender: UIButton) {
        //Check if action is valid
        //Post "like" to server
        //Update image
    }
    
    @IBAction func PostCommentButtonTouch(sender: UIButton) {
        
        if parentView is HomeViewController {
            (parentView as! HomeViewController).selectedPostCellId = PostId
        }
        if parentView is TrendingViewController {
            (parentView as! TrendingViewController).selectedPostCellId = PostId
        }
        parentView.performSegueWithIdentifier("ShowComments", sender:self)
    }
}
