//
//  CommentData.swift
//  Gegder
//
//  Created by Yi Hao on 4/7/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import Foundation

class CommentData {
    class CommentEntry {
        var name : String?
        var datetime : String?
        var comment : String?
    }
    
    var entries = [CommentEntry]()
    
    func clearEntries() {
        entries.removeAll(keepCapacity: false)
    }
    
    func addEntriesFromJSON(data: JSON) {
        
        for (index: String, post: JSON) in data {
            
            let entry = CommentEntry()
//            entry.title = post["title"].string!
//            entry.username = post["username"].string!
//            entry.location = post["location"].string!
//            entry.media_url = post["link_url"].string!
//            entry.created_datetime = post["created_datetime"].string!
//            entry.hash_tag = post["hash_tag"].string!
//            entry.description = post["description"].string!
//            entry.total_comments = post["total_comments"].string!
//            entry.total_likes = post["total_likes"].string!
//            entry.total_dislikes = post["total_dislikes"].string!
//            entry.is_like = post["is_like"].bool!
//            entry.is_dislike = post["is_dislike"].bool!
//            entry.post_id = post["id"].string!
//            entry.display_order = post["display_order"].string!
            
            entries.append(entry)
        }
    }
    
    func addEntriesToFrontFromJSON(data: JSON) {
        
        var oldEntries = entries
        var newEntries = [CommentEntry]()
        
        for (index: String, post: JSON) in data {
            
            let entry = CommentEntry()
//            entry.title = post["title"].string!
//            entry.username = post["username"].string!
//            entry.location = post["location"].string!
//            entry.media_url = post["link_url"].string!
//            entry.created_datetime = post["created_datetime"].string!
//            entry.hash_tag = post["hash_tag"].string!
//            entry.description = post["description"].string!
//            entry.total_comments = post["total_comments"].string!
//            entry.total_likes = post["total_likes"].string!
//            entry.total_dislikes = post["total_dislikes"].string!
//            entry.is_like = post["is_like"].bool!
//            entry.is_dislike = post["is_dislike"].bool!
//            entry.post_id = post["id"].string!
//            entry.display_order = post["display_order"].string!
            
            newEntries.append(entry)
        }
        
        entries = newEntries + oldEntries
        
    }
}