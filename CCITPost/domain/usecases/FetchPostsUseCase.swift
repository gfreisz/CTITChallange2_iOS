//
//  FetchPostUseCase.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation
import RxSwift

struct FetchPostsUseCase {
    private let repository: IPostRepository
    
    init(repository: IPostRepository = PostRepository()) {
        self.repository = repository
    }
    
    func execute(searchText: String? = nil) -> Observable<[PostModel]> {
        return repository
            .fetchPost(searchText: searchText)
            .asObservable()
    }
}
