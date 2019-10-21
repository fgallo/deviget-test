//
//  PostResponse.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

struct PostsResponse: Decodable {
    let posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum ChildrenKey: CodingKey {
        case children
    }
    
    init(from decoder: Decoder) throws {
        let rootKeys = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try rootKeys.nestedContainer(keyedBy: ChildrenKey.self, forKey: .data)
        
        do {
            var posts = try dataContainer.nestedUnkeyedContainer(forKey: .children)
            var allPosts = [Post]()
            
            while !posts.isAtEnd {
                let data = try posts.nestedContainer(keyedBy: CodingKeys.self)
                let post = try data.decode(Post.self, forKey: .data)
                allPosts.append(post)
            }
            self.posts = allPosts
        } catch {
            self.posts = []
        }
    }
    
}
