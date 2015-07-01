//
//  TrendingViewController.swift
//  Gegder
//
//  Created by Ben on 11/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var TrendingTableView: UITableView!
    let postCellId = "PostCell2"
    let data = PostData()
    let userID = (UIApplication.sharedApplication().delegate as! AppDelegate).userID
    var refreshControl: UIRefreshControl!
    var imageCache = [String:UIImage]()
    
    //camera stuff
    let picker = UIImagePickerController()
    var newImage: UIImage?

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
                self.data.clearEntries()
                self.data.addEntriesFromJSON(posts)
                self.TrendingTableView.reloadData()
            }
        })
        
        // Camera stuff
        picker.delegate = self
        
        // Pull to refresh code
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "getNewPosts", forControlEvents: UIControlEvents.ValueChanged)
        self.TrendingTableView.addSubview(refreshControl)
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
        
        //post contains post data
        let post = data.entries[indexPath.row]
        
        //username
        cell.UserLabel.text = post.username
        //location
        cell.UserLocation.text = post.location
        
        // Insert placeholder image else reused image will show up
        cell.PostImage.image = UIImage(named:"post_default")
        
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
    
    func getNewPosts() {
        
        println("Getting new trending posts...")
        
        var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_trending_list/" + userID!
        let url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var posts = JSON(data: data!)
                self.data.clearEntries()
                self.data.addEntriesFromJSON(posts)
                self.TrendingTableView.reloadData()
            }
            
            self.refreshControl.endRefreshing()
        })
    }
    
    //camera stuff
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "GoToNewPost") {
            var nc = segue.destinationViewController as! UINavigationController
            var vc = nc.viewControllers.first as! NewPostViewController
            
            vc.newImage = self.newImage
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {

        newImage = info[UIImagePickerControllerOriginalImage] as? UIImage //2
        
        dismissViewControllerAnimated(true, completion: nil) //5
        self.performSegueWithIdentifier("GoToNewPost", sender:self)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func shootPhoto(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo
            picker.showsCameraControls = true
            presentViewController(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }

}

