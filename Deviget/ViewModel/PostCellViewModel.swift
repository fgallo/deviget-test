//
//  PostCellViewModel.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation
import UIKit

protocol FetchImageDelegate: class {
    func fetchImageSuccess(_ image: UIImage)
}

class PostCellViewModel {
    
    let author: String
    let title: String
    let createdTime: String
    let numberOfComments: String
    
    private var request: AnyObject?
    
    weak var delegate: FetchImageDelegate?
    
    init(post: Post) {
        self.author = post.author
        self.title = post.title
        self.numberOfComments = "\(post.numberOfComments) comments"
        
        let date = Date(timeIntervalSince1970: post.created)
        self.createdTime = date.timeAgo()
        
        fetchImage(url: URL(string: post.thumbnail ?? ""))
    }
    
    private func fetchImage(url: URL?) {
        if let url = url {
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
