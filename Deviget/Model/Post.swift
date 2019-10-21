//
//  Post.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let id: String
    let author: String
    let title: String
    let thumbnail: String?
    let numberOfComments: Int
    let created: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case title
        case thumbnail
        case numberOfComments = "num_comments"
        case created
    }
}
