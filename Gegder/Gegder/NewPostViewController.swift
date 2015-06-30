//

//  NewPostViewController.swift
//  Gegder
//
//  Created by Yi Hao on 29/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var hashtagField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraPreview: UIImageView!
    var newImage: UIImage?
    let userID = (UIApplication.sharedApplication().delegate as! AppDelegate).userID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cameraPreview.image = newImage
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardNotification:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardNotification:"), name:UIKeyboardWillHideNotification, object: nil)
    
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func PostButton(sender: AnyObject) {
        println("post!")
        println(hashtagField.text)
        
//        var image : UIImage = UIImage(named:"testphoto")!
//        var imageData = UIImageJPEGRepresentation(image, 0.2)
//        
        var imageData = UIImageJPEGRepresentation(newImage, 0.2)
//        var imageData = UIImagePNGRepresentation(newImage)
        let base64String = imageData.base64EncodedStringWithOptions(.allZeros)
        
//        println(base64String)
        
//        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
//        var decodedimage = UIImage(data: decodedData!)
//        println(decodedimage)
        
        let newBase64String = base64String.stringByReplacingOccurrencesOfString("+", withString: "%2B")
        
        var postData1 = "jpegImageEncoded=" + newBase64String + "&latestPostId=" + "199C77C04356608030806A2D40E93DAE"
        
        var postData2 = "&userId=" + userID! + "&isLogin=" + "0"
        
        var postData = postData1 + postData2
        
        let urlPath: String = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_image_post"
        var url = NSURL(string: urlPath)
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        
        request.HTTPMethod = "POST"
        request.timeoutInterval = 60
        request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPShouldHandleCookies=false
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(strData)
                var posts = JSON(data: data!)
                println("Data received: \(posts.count)")
                println(posts)
            }
        })
        
        //let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
        //var decodedimage = UIImage(data: decodedData!)
//        println(decodedimage)
        //cameraPreview.image = decodedimage as UIImage!
        
        //self.dismissViewControllerAnimated(true, completion: nil)
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
            self.bottomConstraint?.constant = isShowing ? endFrameHeight : 0.0
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
}

