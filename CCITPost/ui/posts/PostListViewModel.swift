//
//  PostListViewModel.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation
import RxSwift

class PostListViewModel: ObservableObject {
    private var fetchPostsUseCase = FetchPostsUseCase()
    private var removePostUseCase = RemovePostUseCase()
    private var addPostUseCase = AddPostUseCase()
    
    @Published var postList: [PostModel] = []
    let disposeBag = DisposeBag()
    
    init() {
        fetchPostsUseCase.execute()
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] posts in
                self?.postList = posts
            }, onError: { error in
                print (error)
            })
            .disposed(by: disposeBag)
    }
    
    func search(matching: String) {
        fetchPostsUseCase.execute(searchText: matching)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] posts in
                self?.postList = posts
            }, onError: { error in
                print (error)
            })
            .disposed(by: disposeBag)
    }
    
    func addPost(title: String, description: String) {
        addPostUseCase.execute(title: title, description: description)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] post in
                self?.postList.append(post)
            }, onError: { error in
                print (error)
            })
            .disposed(by: disposeBag)
        
    }
    
    func deletePost(at offsets: IndexSet) {
        guard let post = offsets.map({ self.postList[$0] }).first else { return }
        
        removePostUseCase.execute(post: post)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] canRemove in
                if canRemove {
                    self?.postList.remove(atOffsets: offsets)
                }
            }, onError: { error in
                print (error)
            })
            .disposed(by: disposeBag)
    }
}
