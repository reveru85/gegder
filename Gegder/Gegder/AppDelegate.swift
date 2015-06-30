//
//  AppDelegate.swift
//  Gegder
//
//  Created by Ben on 11/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit
import CryptoSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    internal var userID: String?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let deviceID = UIDevice.currentDevice().identifierForVendor.UUIDString
        let deviceHash = deviceID.md5()
        
        var urlString = "http://dev.snapsnap.com.sg/index.php/user/load_user/" + deviceHash!
        
        //Get UserID from server based on deviceID's hash
        var url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var user = JSON(data: data!)
                
                // Prints value of specific key in JSON object (dictionary)
                self.userID = user["id"].string
                println(self.userID)
                
                // Prints all key-value pairs of JSON object (dictionary)
//                for (key: String, value: JSON) in user {
//                    println("\(key) : \(value)")
//                }
                
                var welcomeViewController = self.window!.rootViewController as! WelcomeViewController
                welcomeViewController.userIDLoadComplete()
            }
        })
        
        // Override point for customization after application launch.
        var navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.titleTextAttributes = [NSFontAttributeName: UIFont(name: "PoetsenOne", size: 24)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBarAppearance.tintColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        
        // Test code for posting
        // http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_trending_list/dphodto/dphodto_image_post
        
        
        // Test image base64 encode
        var image : UIImage = UIImage(named:"ic_share_facebook")!
        var imageData = UIImagePNGRepresentation(image)
        //var imageData = UIImageJPEGRepresentation(image, 0.2)
        
        let base64String = imageData.base64EncodedStringWithOptions(.allZeros)
        
//        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
//        var decodedimage = UIImage(data: decodedData!)
//        println(decodedimage)
        
        
        var newPost = JSON(["jpegImageEncoded":"", "latestPostId":"", "userId":"", "timezone":"", "description":"", "isLogin":""])
        
        newPost["jpegImageEncoded"].string = base64String
        newPost["latestPostId"].string = "199C77C04356608030806A2D40E93DAE"
        newPost["userId"].string = "3E3734A45B280196F042AAA76117583E"
        newPost["isLogin"].string = "0"
        
        println(newPost)
        
        var postData = "jpegImageEncoded=" + base64String + "&latestPostId=" + "199C77C04356608030806A2D40E93DAE" + "&userId=" + "3E3734A45B280196F042AAA76117583E" + "&timezone=" + "" + "&description=" + "" + "&isLogin=" + "0"
        
        println(postData)
        
        let urlPath: String = "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_image_post"
        var url1 = NSURL(string: urlPath)
        var request1: NSMutableURLRequest = NSMutableURLRequest(URL: url1!)
        
        println(url1)
        
        request1.HTTPMethod = "POST"
        request1.timeoutInterval = 60
        request1.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
        request1.HTTPShouldHandleCookies=false
        
        println("Sending new post...")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if data != nil {
                var posts = JSON(data: data!)
                println("Data received: \(posts.count)")
                println(posts)
            }
        })
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

