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
                //println(user["id"])
                self.userID = user["id"].string
                
                // Prints all key-value pairs of JSON object (dictionary)
//                for (key: String, value: JSON) in user {
//                    println("\(key) : \(value)")
//                }
            }
        })
        
        // Test code for SwiftyJSON (Get First Load Posts API)
//        let url = NSURL(string: "http://dev.snapsnap.com.sg/index.php/dphodto/dphodto_list/E248326F006BFB87178DF6A238275DA8")
//        var request = NSURLRequest(URL: url!)
//        let queue: NSOperationQueue = NSOperationQueue.mainQueue()
//        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            if data != nil {
//                var posts = JSON(data: data!)
//                
//                for (index: String, post: JSON) in posts {
//                    println(post["location"]);
//                }
//            }
//        })
        
        // Override point for customization after application launch.
        var navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.titleTextAttributes = [NSFontAttributeName: UIFont(name: "PoetsenOne", size: 24)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBarAppearance.tintColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
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

