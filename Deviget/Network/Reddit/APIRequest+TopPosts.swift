//
//  APIRequest+TopPosts.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

extension APIRequest: NetworkRequest {
    
    func decode(_ data: Data) -> PostsResponse? {
         let postsResponse = try? JSONDecoder().decode(PostsResponse.self, from: data)
         return postsResponse
    }
    
    func load(withCompletion completion: @escaping (PostsResponse?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
    
}
