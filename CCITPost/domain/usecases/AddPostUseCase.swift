//
//  AddPostUseCase.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation
import RxSwift

struct AddPostUseCase {
    private let repository: IPostRepository
    
    init(repository: IPostRepository = PostRepository()) {
        self.repository = repository
    }
    
    func execute(title: String, description: String) -> Observable<PostModel> {
        let newPost = PostModel(id: "", title: title, dscription: description)        
        return repository
            .addPost(newPost)
            .asObservable()
    }
}
