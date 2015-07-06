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
    var UserId: String!
    var IsLike: Bool!
    var IsDislike: Bool!
    var parentView: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func PostLikeButtonTouch(sender: UIButton) {
        
        if parentView is HomeViewController {
            
            if IsDislike == false {
                
                // Like post API
                var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/action_like/" + PostId! + "/" + UserId!
                let url = NSURL(string: urlString)
                var request = NSURLRequest(URL: url!)
                let queue: NSOperationQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if data != nil {
                        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                        
                        if str == "completed" {
                            // Update immediate UI
                            self.PostLikeButton.imageView?.image = UIImage(named:"ic_like_on")
                            self.IsLike = true;
                            
                            // Update post entry variable in HomeViewController (backend data)
                            (self.parentView as! HomeViewController).data.likePost(self.PostId!)
                            
                            // Update post cell display in HomeViewController (frontend display)
                            var likesInt = self.PostLikeCount.text?.toInt()
                            likesInt!++
                            self.PostLikeCount.text = String(likesInt!)
                        }
                        else if str == "liked" {
                            self.PostLikeButton.imageView?.image = UIImage(named:"ic_like_on")
                            
                            var likeAlert = UIAlertController(title: "", message: "You have liked the post.", preferredStyle: UIAlertControllerStyle.Alert)
                            likeAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                            (self.parentView as! HomeViewController).presentViewController(likeAlert, animated: true, completion: nil)
                        }
                    }
                })
            }
            else {
                
                var dislikeAlert = UIAlertController(title: "", message: "You have disliked the post.", preferredStyle: UIAlertControllerStyle.Alert)
                dislikeAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                (parentView as! HomeViewController).presentViewController(dislikeAlert, animated: true, completion: nil)
            }
        }
        if parentView is TrendingViewController {
            //(parentView as! TrendingViewController).selectedPostCellId = PostId
            
            if IsDislike == false {
                
                // Like post API
                var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/action_like/" + PostId! + "/" + UserId!
                let url = NSURL(string: urlString)
                var request = NSURLRequest(URL: url!)
                let queue: NSOperationQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if data != nil {
                        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                        
                        if str == "completed" {
                            // Update immediate UI
                            self.PostLikeButton.imageView?.image = UIImage(named:"ic_like_on")
                            self.IsLike = true;
                            
                            // Update post entry variable in TrendingViewController (backend data)
                            (self.parentView as! TrendingViewController).data.likePost(self.PostId!)
                            
                            // Update post cell display in TrendingViewController (frontend display)
                            var likesInt = self.PostLikeCount.text?.toInt()
                            likesInt!++
                            self.PostLikeCount.text = String(likesInt!)
                        }
                        else if str == "liked" {
                            self.PostLikeButton.imageView?.image = UIImage(named:"ic_like_on")
                            
                            var likeAlert = UIAlertController(title: "", message: "You have liked the post.", preferredStyle: UIAlertControllerStyle.Alert)
                            likeAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                            (self.parentView as! TrendingViewController).presentViewController(likeAlert, animated: true, completion: nil)
                        }
                    }
                })
            }
            else {
                
                var dislikeAlert = UIAlertController(title: "", message: "You have disliked the post.", preferredStyle: UIAlertControllerStyle.Alert)
                dislikeAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                (parentView as! TrendingViewController).presentViewController(dislikeAlert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func PostDislikeButtonTouch(sender: UIButton) {
        
        if parentView is HomeViewController {
        
            if IsLike == false {
                
                // Dislike post API
                var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/action_dislike/" + PostId! + "/" + UserId!
                let url = NSURL(string: urlString)
                var request = NSURLRequest(URL: url!)
                let queue: NSOperationQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if data != nil {
                        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                        
                        if str == "completed" {
                            // Update dislike image
                            self.PostDislikeButton.imageView?.image = UIImage(named:"ic_dislike_on")
                            self.IsDislike = true;
                            
                            // Update post entry variable in HomeViewController (backend data)
                            (self.parentView as! HomeViewController).data.dislikePost(self.PostId!)
                            
                            // Update post cell display in HomeViewController (frontend display)
                            var dislikesInt = self.PostDislikeCount.text?.toInt()
                            dislikesInt!++
                            self.PostDislikeCount.text = String(dislikesInt!)
                        }
                        else if str == "disliked" {
                            self.PostDislikeButton.imageView?.image = UIImage(named:"ic_dislike_on")
                            
                            var dislikeAlert = UIAlertController(title: "", message: "You have disliked the post.", preferredStyle: UIAlertControllerStyle.Alert)
                            dislikeAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                            (self.parentView as! HomeViewController).presentViewController(dislikeAlert, animated: true, completion: nil)
                        }
                    }
                })
            }
            else {
                
                var likeAlert = UIAlertController(title: "", message: "You have liked the post.", preferredStyle: UIAlertControllerStyle.Alert)
                likeAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                (self.parentView as! HomeViewController).presentViewController(likeAlert, animated: true, completion: nil)
            }
        }
        else if parentView is TrendingViewController {
            
            if IsLike == false {
                
                // Dislike post API
                var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/action_dislike/" + PostId! + "/" + UserId!
                let url = NSURL(string: urlString)
                var request = NSURLRequest(URL: url!)
                let queue: NSOperationQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if data != nil {
                        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                        
                        if str == "completed" {
                            // Update dislike image
                            self.PostDislikeButton.imageView?.image = UIImage(named:"ic_dislike_on")
                            self.IsDislike = true;
                            
                            // Update post entry variable in TrendingViewController (backend data)
                            (self.parentView as! TrendingViewController).data.dislikePost(self.PostId!)
                            
                            // Update post cell display in TrendingViewController (frontend display)
                            var dislikesInt = self.PostDislikeCount.text?.toInt()
                            dislikesInt!++
                            self.PostDislikeCount.text = String(dislikesInt!)
                        }
                        else if str == "disliked" {
                            self.PostDislikeButton.imageView?.image = UIImage(named:"ic_dislike_on")
                            
                            var dislikeAlert = UIAlertController(title: "", message: "You have disliked the post.", preferredStyle: UIAlertControllerStyle.Alert)
                            dislikeAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                            (self.parentView as! TrendingViewController).presentViewController(dislikeAlert, animated: true, completion: nil)
                        }
                    }
                })
            }
            else {
                
                var likeAlert = UIAlertController(title: "", message: "You have liked the post.", preferredStyle: UIAlertControllerStyle.Alert)
                likeAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                (self.parentView as! TrendingViewController).presentViewController(likeAlert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func PostCommentButtonTouch(sender: UIButton) {
        
        if parentView is HomeViewController {
            (parentView as! HomeViewController).selectedPostCellId = PostId
            (parentView as! HomeViewController).selectedPostCell = self
        }
        if parentView is TrendingViewController {
            (parentView as! TrendingViewController).selectedPostCellId = PostId
            (parentView as! TrendingViewController).selectedPostCell = self
        }
        parentView.performSegueWithIdentifier("ShowComments", sender:self)
    }
    
    
}
