//
//  PostEntity.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation

struct PostEntity: Codable {
    let id: String
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "post_id"
        case title = "post_title"
        case description = "post_description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
    }
}
