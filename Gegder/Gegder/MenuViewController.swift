//
//  MenuViewController.swift
//  Gegder
//
//  Created by Yi Hao on 9/7/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//


import UIKit

class MenuViewController: UITableViewController {
    
    var parentView: UIViewController!
    var option: Int32!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LaunchWebView(option: Int32) {
        if option != 1 && option != 2 { return }
        
        self.option = option

        parentView.performSegueWithIdentifier("ShowWebView", sender: self)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func AboutButtonTouch(sender: UIButton) {
        LaunchWebView(1)
    }
    
    
    @IBAction func HelpButtonTouch(sender: UIButton) {
        LaunchWebView(2)
    }
}
