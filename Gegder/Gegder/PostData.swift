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
        let userimage : String
        let username : String
        let userlocation : String
        let postimage : String
        init(username : String, userimage : String, userlocation: String, postimage : String) {
            self.username = username
            self.userimage = userimage
            self.userlocation = userlocation
            self.postimage = postimage
        }
    }
    
    // http://dev.snapsnap.com.sg/uploads/b380b40e68402397cdbd6270dbf60757b99b5e2ddf2986d817aa74a28daf7227.jpg
    
    let entries = [
        PostEntry(username: "user1", userimage: "http://dev.snapsnap.com.sg/uploads/b380b40e68402397cdbd6270dbf60757b99b5e2ddf2986d817aa74a28daf7227.jpg", userlocation: "Singapore", postimage: "http://dev.snapsnap.com.sg/uploads/a9b9807d01b596da49037fb75caa0672f0aa2bf976845612ad205378418e5c13.jpg"),
        PostEntry(username: "user2", userimage: "http://dev.snapsnap.com.sg/uploads/b380b40e68402397cdbd6270dbf60757b99b5e2ddf2986d817aa74a28daf7227.jpg", userlocation: "Singapore", postimage: "http://dev.snapsnap.com.sg/uploads/5511cfb41555ad008da03ada02d3a2df927b798cfe996d5962733b37948c0ffe.jpg")
    ]
    
}