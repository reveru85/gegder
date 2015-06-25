//
//  HomeTableViewController.swift
//  Gegder
//
//  Created by Ben on 11/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var HomeTableView: UITableView!
    let postCellId = "PostCell"
    let data = PostData()
    let userID = (UIApplication.sharedApplication().delegate as! AppDelegate).userID
    var lastPostID = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        HomeTableView.estimatedRowHeight = 44
        HomeTableView.rowHeight = UITableViewAutomaticDimension
        
        // Get first load posts
        var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_list/" + userID!
        let url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var posts = JSON(data: data!)
                self.data.clearEntries()
                self.data.addEntriesFromJSON(posts)
                self.HomeTableView.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(postCellId, forIndexPath: indexPath) as! PostTableViewCell
        
//        cell.PostCommentButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        cell.PostLikeButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        cell.PostDislikeButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        // Initialise an instance of PostData class using the current row
        let post = data.entries[indexPath.row]
        
        // Update the UI with the current post
        cell.UserLabel.text = post.username
        cell.UserLocation.text = post.location
    
        if post.media_url != nil {
            if let imageUrl = NSURL(string: post.media_url!) {
                let imageRequest: NSURLRequest = NSURLRequest(URL: imageUrl)
                let queue: NSOperationQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(imageRequest, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    if data != nil {
                        let image = UIImage(data: data)
                        cell.PostImage.image = image
                    }
                    
                })
            }
        }
        
        cell.PostDateTime.text = post.created_datetime
        cell.PostHashtags.text = post.hash_tag
        cell.PostCommentCount.text = post.total_comments
        cell.PostLikeCount.text = post.total_likes
        cell.PostDislikeCount.text = post.total_dislikes
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var height = scrollView.frame.size.height
        var contentYoffset = scrollView.contentOffset.y
        var distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < height {
            // Reached end of table
            getPreviousPosts(data.entries.last?.post_id!)
        }
    }
    
    func getPreviousPosts(postID : String?) {
        
        // Track the last post ID globally so as to not make repeated "Get Previous Posts" on the same last post
        if lastPostID != postID {
            lastPostID = postID!
            
            // Get Previous Posts based on Oldest Post
            var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_previous_post/" + postID! + "/" + userID!
            let url = NSURL(string: urlString)
            var request = NSURLRequest(URL: url!)
            let queue: NSOperationQueue = NSOperationQueue.mainQueue()
            NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if data != nil {
                    var posts = JSON(data: data!)
                    println("There are \(posts.count) new posts")
                    
                    // Only add if JSON from server contains more posts
                    if posts.count != 0 {
                        self.data.addEntriesFromJSON(posts)
                        self.HomeTableView.reloadData()
                    }
                }
            })
        }
    }
}

