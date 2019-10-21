//
//  TopPostsResource.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

struct TopPostsResource: APIResource {
    typealias ModelType = PostsResponse
    let methodPath = "/top"
    var parameters: [String : String]
    
    init(limit: Int) {
        self.parameters = ["limit" : "\(limit)"]
    }
}
