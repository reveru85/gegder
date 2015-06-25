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
    var firstLoadComplete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        HomeTableView.estimatedRowHeight = 44
        HomeTableView.rowHeight = UITableViewAutomaticDimension
        
        // Get First Load Posts API
        var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_list/" + userID!
        let url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var posts = JSON(data: data!)
                
                //first load clear placeholder entry
                self.data.clearEntries()
                self.data.addEntriesFromJSON(posts)
                self.HomeTableView.reloadData()
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
        
//        cell.PostCommentButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        cell.PostLikeButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        cell.PostDislikeButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
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
        
        // Update rows remaining based on the currently loaded row
//        println("\(data.entries.count) \(indexPath.row)")
//        let rowsRemaining = data.entries.count - indexPath.row
//        if rowsRemaining < 3 {
//            println("Reload now: \(rowsRemaining)")
//        }
        
        return cell
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if firstLoadComplete {
            println(indexPath.row)
            if indexPath.row + 1 == data.entries.count {
                println("TRIGGER")
                
//                // Get First Load Posts API
//                var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_list/" + userID!
//                let url = NSURL(string: urlString)
//                var request = NSURLRequest(URL: url!)
//                let queue: NSOperationQueue = NSOperationQueue.mainQueue()
//                NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//                    if data != nil {
//                        var posts = JSON(data: data!)
//                        
//                        //first load clear placeholder entry
//                        self.data.clearEntries()
//                        self.data.addEntriesFromJSON(posts)
//                        self.HomeTableView.reloadData()
//                    }
//                })
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        firstLoadComplete = true;
    }
}

