//
//  TrendingViewController.swift
//  Gegder
//
//  Created by Ben on 11/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TrendingTableView: UITableView!
    let postCellId = "PostCell2"
    let data = PostData()
    let userID = (UIApplication.sharedApplication().delegate as! AppDelegate).userID

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TrendingTableView.delegate = self
        TrendingTableView.dataSource = self
        TrendingTableView.estimatedRowHeight = 44
        TrendingTableView.rowHeight = UITableViewAutomaticDimension
        
        // Get First Load Posts API
        var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_trending_list/" + userID!
        let url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var posts = JSON(data: data!)
                
                //first load clear placeholder entry
                self.data.clearEntries()
                
                self.data.addEntriesFromJSON(posts)
                
                println(self.data.entries.count)
                
                self.TrendingTableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(postCellId, forIndexPath: indexPath) as! PostTableViewCell
        
        cell.PostCommentButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        cell.PostLikeButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        cell.PostDislikeButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        //post contains post data
        let post = data.entries[indexPath.row]
        
        //username
        cell.UserLabel.text = post.username
        //location
        cell.UserLocation.text = post.location
        //async image load
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

}

