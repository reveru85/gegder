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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        HomeTableView.estimatedRowHeight = 44
        HomeTableView.rowHeight = UITableViewAutomaticDimension
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
        cell.UserLocation.text = post.userlocation
        
        //test async image load
        
        if let imageUrl = NSURL(string: post.postimage) {
            let imageRequest: NSURLRequest = NSURLRequest(URL: imageUrl)
            let queue: NSOperationQueue = NSOperationQueue.mainQueue()
            NSURLConnection.sendAsynchronousRequest(imageRequest, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if data != nil {
                    let image = UIImage(data: data)
                    cell.PostImage.image = image
                }
            
            })
        }
        
        
        return cell
    }
}

