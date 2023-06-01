//
//  PostRepository.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation
import RxSwift

struct PostRepository : IPostRepository {
    private let apiProvider: IAPIPost
    
    init(apiProvider: IAPIPost = APIPost()) {
        self.apiProvider = apiProvider
    }
    
    func fetchPost(searchText: String?) -> Observable<[PostModel]> {
        return self.apiProvider
            .fetchPosts(searchText: searchText)
            .map { postList -> [PostModel] in postList.map(PostModel.fromEntity(_:)) }
            .asObservable()
    }
    
    func addPost(_ post: PostModel) -> Observable<PostModel> {
        return self.apiProvider
            .addPost(title: post.title, description: post.dscription)
            .map { post -> PostModel in PostModel.fromEntity(post) }
            .asObservable()
    }
    
    func removePost(_ post: PostModel) -> Observable<PostModel> {
        return self.apiProvider
            .removePost(post.id)
            .map { post -> PostModel in PostModel.fromEntity(post) }
            .asObservable()
    }
}
