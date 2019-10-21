//
//  PostCellViewModel.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

class PostCellViewModel {
    
    let author: String
    let title: String
    let createdTime: String
    let numberOfComments: String
    let thumbnailURL: URL?
    
    init(post: Post) {
        self.author = post.author
        self.title = post.title
        
        let date = Date(timeIntervalSince1970: post.created)
        self.createdTime = date.timeAgo()
        
        
        self.numberOfComments = "\(post.numberOfComments) comments"
        self.thumbnailURL = URL(string: post.thumbnail ?? "")
    }
    
}
