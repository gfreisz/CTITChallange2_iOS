//
//  APIServiceMock.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 31/5/23.
//

import Foundation
import RxSwift

class APIServiceMock : APIService {
    init() {
        let urlSessionConfig = URLSessionConfiguration.ephemeral
        urlSessionConfig.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: urlSessionConfig)
        super.init(using: session)
    }
    
    override func get<T>(from endpoint: String, type: T.Type, query: [URLQueryItem]? = nil) -> Observable<T> where T : Decodable {
        URLProtocolMock.requestHandler = { request in
            if (query?.count ?? 0) > 0 {
                return (HTTPURLResponse(), APIServiceResponseMock.getJSONPostList(searchText: (query?[0].value) ?? nil))
            } else {
                return (HTTPURLResponse(), APIServiceResponseMock.getJSONPostList())
            }
        }
        
        return super.get(from: endpoint, type: type, query: query)
    }
    
    override func post<T>(from endpoint: String, type: T.Type, query: [URLQueryItem]? = nil, body: Dictionary<String, String>? = nil) -> Observable<T> where T : Decodable {
        URLProtocolMock.requestHandler = { request in
            if request.url!.absoluteString.hasSuffix(NetworkConstants.ADD_POST) {
                return (HTTPURLResponse(), APIServiceResponseMock.getJSONAddPost(body: body!))
            } else {
                return (HTTPURLResponse(), APIServiceResponseMock.getJSONRemovePost(body: body!))
            }
            
        }
        
        return super.post(from: endpoint, type: type, query: query, body: body)
    }
}
