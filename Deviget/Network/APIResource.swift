//
//  APIResource.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://api.reddit.com")!
        components.path = methodPath
        return components.url!
    }
}
