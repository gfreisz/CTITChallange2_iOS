//
//  APIPost.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation
import RxSwift

final class APIPost : IAPIPost {
    private var service: APIService
    
    init(service: APIService = APIServiceMock()) {
        self.service = service
    }
    
    func fetchPosts(searchText: String?) -> Observable<[PostEntity]> {
        var queryItems: [URLQueryItem] = []
        if let query = searchText {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
        
        return self.service.get(
            from: NetworkConstants.FETCH_POST,
            type: [PostEntity].self,
            query: queryItems
        )
    }
    
    func addPost(title: String, description: String) -> Observable<PostEntity> {
        return self.service.post(
            from: NetworkConstants.ADD_POST,
            type: PostEntity.self,
            body: [ "post_title": title, "post_description": description ]
        )
    }
    
    func removePost(_ id: String) -> Observable<PostEntity> {
        return self.service.post(
            from: NetworkConstants.REMOVE_POST,
            type: PostEntity.self,
            body: [ "post_id": id ]
        )
    }
}
