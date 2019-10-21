//
//  PostDetailsViewModel.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

protocol PostDetailsDelegate: class {
    func refreshPostDetails()
}

class PostDetailsViewModel {
    
    private var post: Post?
    
    weak var delegate: PostDetailsDelegate?
    
    init(post: Post?) {
        self.post = post
    }
    
    func postAuthor() -> String? {
        return post?.author
    }
    
    func postTitle() -> String? {
        return post?.title
    }
    
    func postTimeAgo() -> String? {
        let date = Date(timeIntervalSince1970: post?.created ?? 0.0)
        return date.timeAgo()
    }
    
}


// MARK: - PostSelectionDelegate

extension PostDetailsViewModel: PostSelectionDelegate {
    
    func postSelected(_ post: Post) {
        self.post = post
        self.delegate?.refreshPostDetails()
    }
    
}
