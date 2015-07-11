//
//  PostTableViewCell.swift
//  Gegder
//
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
                var urlString = "http://20backendapi15.gegder.com/index.php/dphodto/action_like/" + PostId! + "/" + UserId!
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
            
            if IsDislike == false {
                
                // Like post API
                var urlString = "http://20backendapi15.gegder.com/index.php/dphodto/action_like/" + PostId! + "/" + UserId!
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
                var urlString = "http://20backendapi15.gegder.com/index.php/dphodto/action_dislike/" + PostId! + "/" + UserId!
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
                var urlString = "http://20backendapi15.gegder.com/index.php/dphodto/action_dislike/" + PostId! + "/" + UserId!
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
    
    @IBAction func MoreButtonTouch(sender: UIButton) {
        
        let optionMenu = UIAlertController(title: "More options", message: nil, preferredStyle: .Alert)
        
        let shareAction = UIAlertAction(title: "Share on Facebook", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if self.parentView is HomeViewController {
                
                let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
                content.contentURL = NSURL(string: "http://gegder.com/post.php?id=" + self.PostId)
                content.contentTitle = self.PostTitle.text
                content.contentDescription = self.PostHashtags.text
                content.imageURL = NSURL(string: (self.parentView as! HomeViewController).data.findEntry(self.PostId).media_url!)
                
                let button : FBSDKShareButton = FBSDKShareButton()
                button.shareContent = content
                button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 50, 100, 25)
                button.hidden = true
                button.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
                
            } else if self.parentView is TrendingViewController {
                
                let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
                content.contentURL = NSURL(string: "http://gegder.com/post.php?id=" + self.PostId)
                content.contentTitle = (self.parentView as! TrendingViewController).data.findEntry(self.PostId).title!
                content.contentDescription = (self.parentView as! TrendingViewController).data.findEntry(self.PostId).hash_tag!
                content.imageURL = NSURL(string: (self.parentView as! TrendingViewController).data.findEntry(self.PostId).media_url!)
                
                let button : FBSDKShareButton = FBSDKShareButton()
                button.shareContent = content
                button.frame = CGRectMake((UIScreen.mainScreen().bounds.width - 100) * 0.5, 50, 100, 25)
                button.hidden = true
                button.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
        })

        let flagAction = UIAlertAction(title: "Flag as inappropriate", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if self.parentView is HomeViewController {
                
                var urlString = "http://20backendapi15.gegder.com/index.php/dphodto/action_flag_as_inappropriate/" + self.PostId
                let url = NSURL(string: urlString)
                var request = NSURLRequest(URL: url!)
                let queue: NSOperationQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if data != nil {
                        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                        
                        if str == "completed" {
                            // Remove post from post data in code behind and refresh view
                            (self.parentView as! HomeViewController).data.removeEntry(self.PostId)
                            (self.parentView as! HomeViewController).HomeTableView.reloadData()
                            
                            var flagAlert = UIAlertController(title: "", message: "You have flagged the post as inappropriate.", preferredStyle: UIAlertControllerStyle.Alert)
                            flagAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                            (self.parentView as! HomeViewController).presentViewController(flagAlert, animated: true, completion: nil)
                        }
                    }
                })
            } else if self.parentView is TrendingViewController {
                
                var urlString = "http://20backendapi15.gegder.com/index.php/dphodto/action_flag_as_inappropriate/" + self.PostId
                let url = NSURL(string: urlString)
                var request = NSURLRequest(URL: url!)
                let queue: NSOperationQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if data != nil {
                        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                        
                        if str == "completed" {
                            // Remove post from post data in code behind and refresh view
                            (self.parentView as! TrendingViewController).data.removeEntry(self.PostId)
                            (self.parentView as! TrendingViewController).TrendingTableView.reloadData()
                            
                            var flagAlert = UIAlertController(title: "", message: "You have flagged the post as inappropriate.", preferredStyle: UIAlertControllerStyle.Alert)
                            flagAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
                            (self.parentView as! TrendingViewController).presentViewController(flagAlert, animated: true, completion: nil)
                        }
                    }
                })
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })

        optionMenu.addAction(shareAction)
        optionMenu.addAction(flagAction)
        optionMenu.addAction(cancelAction)
        
        parentView.presentViewController(optionMenu, animated: true, completion: nil)
    }
}
