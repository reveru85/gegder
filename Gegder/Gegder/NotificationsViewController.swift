//
//  NotificationsViewController.swift
//  Gegder
//
//  Created by Ben on 11/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var NotificationsTableView: UITableView!
    let postCellId = "NotificationsCell"
    
    class NotificationsEntry {
        var title : String?
        var datetime : String?
        var user : String?
        var message : String?
    }
    
    var entries = [NotificationsEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationsTableView.delegate = self
        NotificationsTableView.dataSource = self
        NotificationsTableView.estimatedRowHeight = 44
        NotificationsTableView.rowHeight = UITableViewAutomaticDimension
        
        //init fixed data
        var entry = NotificationsEntry()
        entry.title = "Welcome to Gegder"
        entry.datetime = "30 May 2015, 00:00"
        entry.user = "Gegder Administrator"
        entry.message = "Welcome to Gegder from admin"
        
        entries.append(entry)
        
        var entry2 = NotificationsEntry()
        entry2.title = "Announcement"
        entry2.datetime = "30 May 2015, 00:00"
        entry2.user = "Gegder Administrator"
        entry2.message = "Announcement"
        
        entries.append(entry2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(postCellId, forIndexPath: indexPath) as! NotificationsTableViewCell
        
        //prevent layout constraints error
        cell.contentView.bounds = CGRectMake(0, 0, 99999, 99999);
        
        // Initialise an instance of PostData class using the current row
        let post = entries[indexPath.row]

        cell.Title.text = post.title
        cell.DateTime.text = post.datetime

        return cell
    }
}

