//
//  Post.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let author: String
    let title: String
    let thumbnail: String?
    let numberOfComments: Int
    let created: Int
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case thumbnail
        case numberOfComments = "num_comments"
        case created
    }
}
