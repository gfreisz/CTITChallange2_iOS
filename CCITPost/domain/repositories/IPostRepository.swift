//
//  IPostRepository.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 31/5/23.
//

import Foundation
import RxSwift

protocol IPostRepository {
    func fetchPost(searchText: String?) -> Observable<[PostModel]>
    func addPost(_ post: PostModel) -> Observable<PostModel>
    func removePost(_ post: PostModel) -> Observable<PostModel>
}
