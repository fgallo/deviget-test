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
    private var totalCount: Int
    private var isFetchInProgress: Bool
    private var resource: TopPostsResource
    private var request: AnyObject?
    
    weak var delegate: FetchPostsDelegate?
    
    init(resource: TopPostsResource) {
        self.resource = resource
        self.posts = []
        self.isFetchInProgress = false
        self.totalCount = 0
    }
    
    
    // MARK: - API
    
    func fetchPosts(refreshing: Bool) {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        
        if refreshing {
            posts = []
            totalCount = 0
            resource.parameters["after"] = ""
        }
        
        if let lastPost = posts.last {
            resource.parameters["after"] = "t3_\(lastPost.id)"
        }
        
        let request = APIRequest(resource: resource)
        self.request = request
        
        request.load { [weak self] (postsResponse: PostsResponse?) in
            guard let postsResponse = postsResponse else {
                self?.isFetchInProgress = false
                self?.delegate?.fetchPostsFailure()
                return
            }
            self?.isFetchInProgress = false
            self?.totalCount += postsResponse.posts.count
            self?.posts.append(contentsOf: postsResponse.posts)
            self?.delegate?.fetchPostsSuccess()
        }
    }
    
    
    // MARK: - Posts
    
    func postForRowAt(indexPath: IndexPath) -> Post {
        return posts[indexPath.row]
    }
    
    func viewModelForRowAt(indexPath: IndexPath) -> PostCellViewModel {
        let post = posts[indexPath.row]
        return PostCellViewModel(post: post)
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func totalNumberOfPosts() -> Int {
        return totalCount
    }
    
}
