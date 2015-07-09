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
    
    let loginView : FBSDKLoginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ConnectFBButton.layer.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.3).CGColor
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
//            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
            loginView.hidden = true
            
//            loginView.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
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
        println("User Logged In")
        
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
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    @IBAction func FBButtonTouch(sender: UIButton) {
        loginView.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
}

