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
        let username : String
        let image : String
        init(username : String, image : String) {
            self.image = image
            self.username = username
        }
    }
    
    let entries = [
        PostEntry(username: "user1", image: "http://dev.snapsnap.com.sg/uploads/a9b9807d01b596da49037fb75caa0672f0aa2bf976845612ad205378418e5c13.jpg"),
        PostEntry(username: "user2", image: "http://dev.snapsnap.com.sg/uploads/5511cfb41555ad008da03ada02d3a2df927b798cfe996d5962733b37948c0ffe.jpg")
    ]
    
}