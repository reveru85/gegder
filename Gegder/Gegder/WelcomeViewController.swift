//
//  WelcomeViewController.swift
//  Gegder
//
//  Created by Ben on 11/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var LoadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var NotNowButton: UIButton!
    @IBOutlet weak var ConnectFBButton: UIButton!
    
    var userID = (UIApplication.sharedApplication().delegate as! AppDelegate).userID
    var fbId = ""
    var firstName = ""
    var lastName = ""
    var gender = ""
    var email = ""
    var timezone = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ConnectFBButton.layer.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.3).CGColor
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 100)
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            println("Existing login")
            // User is already logged in, do work such as go to next view controller.
            (UIApplication.sharedApplication().delegate as! AppDelegate).isFBLogin = true
            
            // ADD CODE HERE TO SWITCH VIEW TO HOME VC
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userIDLoadComplete() {
        LoadingSpinner.hidden = true
        ConnectFBButton.hidden = false
        NotNowButton.hidden = false
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("public_profile")
            {
                // Do work
                returnUserData()
            }
        }
    }
    
    @IBAction func FBButtonTouch(sender: UIButton) {
        //loginView.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
        (UIApplication.sharedApplication().delegate as! AppDelegate).isFBLogin = false
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me?fields=id,first_name,last_name,gender,email,timezone", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
                (UIApplication.sharedApplication().delegate as! AppDelegate).isFBLogin = false
            }
            else
            {
                (UIApplication.sharedApplication().delegate as! AppDelegate).isFBLogin = true
                self.fbId = result.valueForKey("id") as! String
                self.firstName = result.valueForKey("first_name") as! String
                self.lastName = result.valueForKey("last_name") as! String
                self.gender = result.valueForKey("gender") as! String
                self.email = result.valueForKey("email") as! String
                self.timezone = result.valueForKey("timezone") as! Int
                
                self.updateUserData()
            }
        })
    }
    
    func updateUserData() {
        // Update user data
        userID = (UIApplication.sharedApplication().delegate as! AppDelegate).userID
        var postData0 = "userId=" + userID! + "&facebookId=" + self.fbId
        var postData1 = "&firstName=" + self.firstName + "&lastName=" + self.lastName
        var postData2 = "&email=" + self.email + "&gender=" + self.gender
        var postData3 = "&timezone=" + String(self.timezone)
        var postData = postData0 + postData1 + postData2 + postData3
        
        let urlPath: String = "http://dev.snapsnap.com.sg/index.php/user/gegder_user_update"
        var url = NSURL(string: urlPath)
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        
        request.HTTPMethod = "POST"
        request.timeoutInterval = 60
        request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPShouldHandleCookies=false
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                if str == "completed" {
                    println("Update complete")
                }
                else if str == "not_updated" {
                    println("Update failed")
                }
            }
        })
    }
}

