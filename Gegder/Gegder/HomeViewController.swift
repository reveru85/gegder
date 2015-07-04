//
//  HomeTableViewController.swift
//  Gegder
//
//  Created by Ben on 11/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var HomeTableView: UITableView!
    let postCellId = "PostCell"
    let data = PostData()
    let userID = (UIApplication.sharedApplication().delegate as! AppDelegate).userID
    var lastPostID = ""
    var refreshControl: UIRefreshControl!
    var imageCache = [String:UIImage]()
    var selectedPostCellId = ""
    
    //camera stuff
    let picker = UIImagePickerController()
    var newImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).homeView = self
        
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
                (UIApplication.sharedApplication().delegate as! AppDelegate).firstPostID = self.data.entries.first!.post_id!
                self.HomeTableView.reloadData()
            }
        })
        
        //camera stuff
        picker.delegate = self
        
        // Pull to refresh code
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "getNewPosts:", forControlEvents: UIControlEvents.ValueChanged)
        self.HomeTableView.addSubview(refreshControl)
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
        
        // Initialise an instance of PostData class using the current row
        let post = data.entries[indexPath.row]
        cell.PostImage.image = UIImage(named:"post_default")
        
        // Assign image URL string as key to image cache
        let urlString = post.media_url
        
        // If this image is already cached, don't re-download
        if (urlString != nil) {
            if let img = imageCache[urlString!] {
                //println("Image exists in cache")
                cell.PostImage.image = img
            }
            else {
                // The image isn't cached, download the img data
                // We should perform this in a background thread
                if urlString != nil {
                    if let imageUrl = NSURL(string: urlString!) {
                        let imageRequest: NSURLRequest = NSURLRequest(URL: imageUrl)
                        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
                        NSURLConnection.sendAsynchronousRequest(imageRequest, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                            if data != nil {
                                
                                //println("Downloading new image from URL...")
                                // Convert the downloaded data in to a UIImage object
                                let image = UIImage(data: data)
                                // Store the image in to our cache
                                self.imageCache[urlString!] = image
                                // Update the cell
                                dispatch_async(dispatch_get_main_queue(), {
                                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                                        //cellToUpdate.imageView?.image = image
                                        (cellToUpdate as! PostTableViewCell).PostImage.image = image
                                    }
                                })
                            }
                        })
                    }
                }
            }
        }

        // Update the UI with the current post
        cell.PostTitle.text = post.title
        cell.UserLabel.text = post.username
        cell.UserLocation.text = post.location
        cell.PostDateTime.text = post.created_datetime
        cell.PostHashtags.text = post.hash_tag
        cell.PostCommentCount.text = post.total_comments
        cell.PostLikeCount.text = post.total_likes
        cell.PostDislikeCount.text = post.total_dislikes
        cell.PostId = post.post_id
        cell.UserId = self.userID
        cell.IsLike = post.is_like
        cell.IsDislike = post.is_dislike
        cell.parentView = self
        
        if post.is_like {
            cell.PostLikeButton.imageView?.image = UIImage(named:"ic_like_on")
        } else {
            cell.PostLikeButton.imageView?.image = UIImage(named:"ic_like")
        }
        
        if post.is_dislike {
            cell.PostDislikeButton.imageView?.image = UIImage(named:"ic_dislike_on")
        } else {
            cell.PostDislikeButton.imageView?.image = UIImage(named:"ic_dislike")
        }
        
        println(post.display_order)
        println(post.post_id)
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var height = scrollView.frame.size.height
        var contentYoffset = scrollView.contentOffset.y
        var distanceFromBottom = scrollView.contentSize.height - contentYoffset
        
        if distanceFromBottom < height {

            // Reached end of table
            let currentLastPostID = data.entries.last?.post_id!
            
            // Track the last post ID globally so as to not make repeated "Get Previous Posts" on the same last post
            if lastPostID != currentLastPostID {
                
                println("Last Post ID: \(lastPostID)")
                println("Current Last: \(currentLastPostID!)")
                
                lastPostID = currentLastPostID!
                getPreviousPosts(currentLastPostID)
            }
        }
    }
    
    func getPreviousPosts(postID : String?) {
    
        println("Loading more posts...")
        
        // Get previous posts based on oldest post
        var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_previous_post/" + postID! + "/" + userID!
        
        println(urlString)
        
        let url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var posts = JSON(data: data!)
                
                // Only add if JSON from server contains more posts
                if posts.count != 0 {
                    
                    println("Number of new posts: \(posts.count)")
                    
                    self.data.addEntriesFromJSON(posts)
                    self.HomeTableView.reloadData()
                }
            }
        })
    }
    
    func getNewPosts(sender:AnyObject) {
        
        println("Getting new posts...")
        
        // Get new posts based on newest post
        var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_new_post/" + self.data.entries.first!.post_id! + "/" + userID!
        
//        println(urlString)
        
        let url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var posts = JSON(data: data!)
                
                // Only add if JSON from server contains more posts
                if posts.count != 0 {
                    
                    println("Number of new posts: \(posts.count)")
                    self.data.addEntriesToFrontFromJSON(posts)
                    (UIApplication.sharedApplication().delegate as! AppDelegate).firstPostID = self.data.entries.first!.post_id!
                    self.HomeTableView.reloadData()
                }
            }
            
            self.refreshControl.endRefreshing()
        })
    }
    
    //prep for segue transitions
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "GoToNewPost") {
            var nc = segue.destinationViewController as! UINavigationController
            var vc = nc.viewControllers.first as! NewPostViewController
            
            vc.newImage = self.newImage
        }
        else if (segue.identifier == "ShowComments") {
            var vc = segue.destinationViewController as! CommentsViewController
            
            vc.postId = self.selectedPostCellId
        }
    }
    
    //camera stuff
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

