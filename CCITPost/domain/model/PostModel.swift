//
//  PostModel.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation

struct PostModel {
    let id: String
    let title: String
    let dscription: String
    
    static func fromEntity(_ post: PostEntity) -> PostModel {
        return PostModel(id: post.id, title: post.title, dscription: post.description)
    }
}
