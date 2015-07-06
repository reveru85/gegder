//
//  WelcomeViewController.swift
//  Gegder
//
//  Created by Ben on 11/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var LoadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var NotNowButton: UIButton!
    @IBOutlet weak var ConnectFBButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ConnectFBButton.layer.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.3).CGColor
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
}

