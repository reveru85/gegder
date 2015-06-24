//
//  PostData.swift
//  Gegder
//
//  Created by Yi Hao on 15/6/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import Foundation

class PostData {
    class PostEntry {
        var title : String?
        var username : String?
        var location : String?
        var media_url : String?
        var created_datetime : String?
        var hash_tag : String?
        var total_comments : String?
        var total_likes : String?
        var total_dislikes : String?
        var is_like : Bool?
        var is_dislike : Bool?
        var post_id : String?
    }
    
    var entries = [PostEntry]()
    
    // http://dev.snapsnap.com.sg/uploads/b380b40e68402397cdbd6270dbf60757b99b5e2ddf2986d817aa74a28daf7227.jpg
    
//    var entries = [
//        PostEntry(username: "user1", userimage: "http://dev.snapsnap.com.sg/uploads/b380b40e68402397cdbd6270dbf60757b99b5e2ddf2986d817aa74a28daf7227.jpg", userlocation: "Singapore", postimage: "http://dev.snapsnap.com.sg/uploads/a9b9807d01b596da49037fb75caa0672f0aa2bf976845612ad205378418e5c13.jpg"),
//        PostEntry(username: "user2", userimage: "http://dev.snapsnap.com.sg/uploads/b380b40e68402397cdbd6270dbf60757b99b5e2ddf2986d817aa74a28daf7227.jpg", userlocation: "Singapore", postimage: "http://dev.snapsnap.com.sg/uploads/5511cfb41555ad008da03ada02d3a2df927b798cfe996d5962733b37948c0ffe.jpg")
//    ]
    
    func addEntriesFromJSON(data: JSON) {
//        for (index: String, post: JSON) in data {
//            println(post["location"]);
//        }
        
        // Prints all key-value pairs of JSON object (dictionary)
//        for (key: String, value: JSON) in data {
//            println("\(key) : \(value)")
//        }
        
        for (index: String, post: JSON) in data {
            let entry = PostEntry()
            entry.title = post["title"].string!
            entry.username = post["username"].string!
            entry.location = post["location"].string!
            entry.media_url = post["link_url"].string!
            entry.created_datetime = post["created_datetime"].string!
            entry.hash_tag = post["hash_tag"].string!
            entry.total_comments = post["total_comments"].string!
            entry.total_likes = post["total_likes"].string!
            entry.total_dislikes = post["total_dislikes"].string!
            entry.is_like = post["is_like"].bool!
            entry.is_dislike = post["is_dislike"].bool!
            entry.post_id = post["id"].string!
            
            entries.append(entry)
        }
        
    }
    
}