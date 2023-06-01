//
//  RemovePostUseCase.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation
import RxSwift

struct RemovePostUseCase {
    private let repository: IPostRepository
    
    init(repository: IPostRepository = PostRepository()) {
        self.repository = repository
    }
    
    func execute(post: PostModel) -> Observable<Bool> {
        return repository
            .removePost(post)
            .map { removedPost -> Bool in post.id == removedPost.id }
            .asObservable()
    }
}
