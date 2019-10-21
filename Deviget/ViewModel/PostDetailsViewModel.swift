//
//  PostDetailsViewModel.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation
import UIKit

protocol PostDetailsDelegate: class {
    func refreshPostDetails()
    func fetchImageSuccess(_ image: UIImage)
}

class PostDetailsViewModel {
    
    private var post: Post?
    private var request: AnyObject?
    
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
    
    private func fetchImage() {
        if let url = URL(string: post?.thumbnail ?? "") {
            let thumbnailRequest = ImageRequest(url: url)
            request = thumbnailRequest
            thumbnailRequest.load { [weak self] (thumbnail: UIImage?) in
                guard let thumbnail = thumbnail else {
                    return
                }
                self?.delegate?.fetchImageSuccess(thumbnail)
            }
        }
    }
    
}


// MARK: - PostSelectionDelegate

extension PostDetailsViewModel: PostSelectionDelegate {
    
    func postSelected(_ post: Post) {
        self.post = post
        self.fetchImage()
        self.delegate?.refreshPostDetails()
    }
    
}
