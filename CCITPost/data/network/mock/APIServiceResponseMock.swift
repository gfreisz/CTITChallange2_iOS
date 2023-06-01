//
//  APIServiceResponseMock.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 31/5/23.
//

import Foundation

class APIServiceResponseMock {
    private static let encoder = JSONEncoder()
    private static var last_post_id = 1
    private static var postList: [PostModelMock] = [
        PostModelMock(post_id: "1", post_title: "Post 1", post_description: "¿Hola como están?")
    ]
    
    static func getJSONPostList(searchText: String? = nil) -> Data {
        var list: [PostModelMock] = []
        if let filter = searchText {
            if filter.isEmpty {
                list = postList
            } else {
                list = postList.filter { post in post.post_title.hasPrefix(filter) }
            }
        } else {
            list = postList
        }
        
        do {
            let data = try APIServiceResponseMock.encoder.encode(list)
            return data
        }catch {
            return Data("{}".utf8)
        }
    }
    
    static func getJSONAddPost(body:  Dictionary<String, String>)  -> Data{
        APIServiceResponseMock.last_post_id += 1
        
        let id = String(APIServiceResponseMock.last_post_id)
        let title = body["post_title"]!
        let description = body["post_description"]!
        
        let newPost = PostModelMock(post_id: id, post_title: title, post_description: description)
        postList.append(newPost)
        
        do {
            let data = try APIServiceResponseMock.encoder.encode(newPost)
            return data
        }catch {
            return Data("{}".utf8)
        }
    }
    
    static func getJSONRemovePost(body:  Dictionary<String, String>)  -> Data{
        let id = body["post_id"]!
        
        let pos = postList.firstIndex { post in post.post_id == id }!
        let removedPost = postList.remove(at: pos)
        
        do {
            let data = try APIServiceResponseMock.encoder.encode(removedPost)
            return data
        }catch {
            return Data("{}".utf8)
        }
    }
}

struct PostModelMock : Codable {
    let post_id: String
    let post_title: String
    let post_description: String
}
