//
//  PostsViewModel.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

protocol FetchPostsDelegate: class {
    func fetchPostsSuccess()
    func fetchPostsFailure()
}

class PostsViewModel {
    private var posts: [Post]
    private var resource: TopPostsResource
    private var request: AnyObject?
    
    weak var delegate: FetchPostsDelegate?
    
    init(resource: TopPostsResource) {
        self.resource = resource
        self.posts = []
    }
    
    
    // MARK: - API
    
    func fetchPosts() {
        let request = APIRequest(resource: resource)
        self.request = request
        request.load { [weak self] (postsResponse: PostsResponse?) in
            guard let postsResponse = postsResponse else {
                self?.delegate?.fetchPostsFailure()
                return
            }
            self?.posts.append(contentsOf: postsResponse.posts)
            self?.delegate?.fetchPostsSuccess()
        }
    }
    
    
    // MARK: - Posts
    
    func viewModelForRowAt(indexPath: IndexPath) -> PostCellViewModel {
        let post = posts[indexPath.row]
        return PostCellViewModel(post: post)
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
}
