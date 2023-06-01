//
//  IAPIPost.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 31/5/23.
//

import Foundation
import RxSwift

protocol IAPIPost {
    func fetchPosts(searchText: String?) -> Observable<[PostEntity]>
    func addPost(title: String, description: String)  -> Observable<PostEntity>
    func removePost(_ id: String) -> Observable<PostEntity>
}
