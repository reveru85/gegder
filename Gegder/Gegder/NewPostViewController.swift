//
//  NewPostViewController.swift
//  Gegder
//
//  Created by Yi Hao on 29/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var cameraPreview: UIImageView!
    var newImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cameraPreview.image = newImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

