//
//  CommentsViewController.swift
//  Gegder
//
//  Created by Yi Hao on 4/7/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var postingBlurView: UIVisualEffectView!
    @IBOutlet weak var CommentsTextField: UITextField!
    @IBOutlet weak var NoCommentsView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint2: NSLayoutConstraint!
    @IBOutlet weak var CommentsTableView: UITableView!
    var postId = ""
    let commentCellId = "CommentCell"
    let data = CommentData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println(postId)
        
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        CommentsTableView.estimatedRowHeight = 44
        CommentsTableView.rowHeight = UITableViewAutomaticDimension
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardNotification:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardNotification:"), name:UIKeyboardWillHideNotification, object: nil)
        
        // Get comments
//        var urlString = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_list/" + userID!
        var urlString = "http://"
        let url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var posts = JSON(data: data!)
                self.data.clearEntries()
                self.data.addEntriesFromJSON(posts)
//                (UIApplication.sharedApplication().delegate as! AppDelegate).firstPostID = self.data.entries.first!.post_id!
                self.CommentsTableView.reloadData()
            }
        })
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ret = data.entries.count
        
        if ret == 0 {
            NoCommentsView.hidden = false
        } else {
            NoCommentsView.hidden = true
        }
        
        return ret
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(commentCellId, forIndexPath: indexPath) as! CommentsTableViewCell
        
        // Initialise an instance of PostData class using the current row
        let post = data.entries[indexPath.row]
        
        // Update the UI with the current post
        cell.UserLabel.text = post.name
        cell.CommentDatetime.text = post.datetime
        cell.Comment.text = post.comment
        
        return cell
    }
    
    func keyboardNotification(notification: NSNotification) {
        let isShowing = notification.name == UIKeyboardWillShowNotification
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            let endFrameHeight = endFrame?.size.height ?? 0.0
            let duration:NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.unsignedLongValue ?? UIViewAnimationOptions.CurveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            self.bottomConstraint?.constant = isShowing ? endFrameHeight - 49 : 0.0
            //self.bottomConstraint2?.constant = isShowing ? endFrameHeight + 7 - 49 : 7.0
            UIView.animateWithDuration(duration,
                delay: NSTimeInterval(0),
                options: animationCurve,
                animations: { self.view.layoutIfNeeded() },
                completion: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func SendComment(sender: UIButton) {
        println("send comment")
        println(CommentsTextField.text)
        
        if CommentsTextField.text.isEmpty {
            println("no comment entered")
            return
        }
        
        //on send comment button clicked
        sender.enabled = false
        CommentsTextField.enabled = false
        postingBlurView.hidden = false
        
        //send comment to server
        
        //reload comments from server on send complete (in async)
        
        //hide sending view and re-enable comments posting (in async)
        sender.enabled = true
        CommentsTextField.enabled = true
        postingBlurView.hidden = true
        
        //clear CommentsTextField if posting succeeded (in async)
        CommentsTextField.text = ""
    }
}

