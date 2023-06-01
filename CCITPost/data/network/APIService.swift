//
//  APIService.swift
//  CCITPost
//
//  Created by Gabriel Freisz on 30/5/23.
//

import Foundation
import RxSwift
import RxCocoa

enum APIError: Error {
    case invalidResponse(URLResponse?)
    case invalidJSON(Error)
}

class APIService {
    private var session: URLSession
    
    init(using session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func get<T: Decodable>(from endpoint: String, type: T.Type, query: [URLQueryItem]? = nil) -> Observable<T> {
        let request = generateGetRequest(for: endpoint, query: query)
        return executeRequest(request, type: type)
    }
    
    func post<T: Decodable>(from endpoint: String, type: T.Type, query: [URLQueryItem]? = nil, body: Dictionary<String, String>? = nil) -> Observable<T> {
        let request = generatePostRequest(for: endpoint, query: query, body: body)
        return executeRequest(request, type: type)
    }
    
    private func executeRequest<T: Decodable>(_ request:URLRequest, type: T.Type)  -> Observable<T> {
        return session.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw APIError.invalidResponse(result.response)
                }
                
                return result.data
            }.map { data in
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    return response
                } catch let error {
                    throw APIError.invalidJSON(error)
                }
            }
            .asObservable()
    }
    
    private func generateGetRequest(for endpoint: String, query: [URLQueryItem]?) -> URLRequest {
        var request = URLRequest(url: generateUrl(for: endpoint, query: query))
        request.httpMethod = "GET"
        return request
    }
    
    private func generatePostRequest(for endpoint: String, query: [URLQueryItem]?, body: Dictionary<String, String>?) -> URLRequest {
        var request = URLRequest(url: generateUrl(for: endpoint, query: query))
        request.httpMethod = "POST"
        
        if let bodyDic = body {
            let bodyData = try? JSONSerialization.data(withJSONObject: bodyDic, options: [])
            request.httpBody = bodyData
        }
        
        return request
    }
    
    private func generateUrl(for endpoint: String, query: [URLQueryItem]?) -> URL {
        var components = URLComponents()
        components.host = NetworkConstants.BASE_URL
        components.path = endpoint
        components.queryItems = query
        
        return components.url!
    }
}
