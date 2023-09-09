//
//  NetworkingManager.swift
//  iOSTakeHomeProject
//
//  Created by Muhammad Saeed on 31/08/2023.
//

import Foundation

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(session: URLSession = .shared,
                             _ endpoint: Endpoints,
                             type: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await session.data(for: request)
        
        guard
            let response = response as? HTTPURLResponse,
            (200...300) ~= response.statusCode
        else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        
       return res
    }
    
    func request(session: URLSession = .shared, _ endpoint: Endpoints) async throws {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (_, response) = try await session.data(for: request)
        
        guard
            let response = response as? HTTPURLResponse,
            (200...300) ~= response.statusCode
        else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
}

extension NetworkingManager {
    enum NetworkingError: Error, LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "URL isn't valid"
            case .invalidData:
                return "Response data isn't valid"
            case .invalidStatusCode:
                return "Status code falls into wrong range"
            case .failedToDecode:
                return "Failed to decode"
            case .custom(let error):
                return "Something went wrong. \(error.localizedDescription)"
            }
        }
    }
}



private extension NetworkingManager {
    func buildRequest(from url: URL, methodType: Endpoints.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        
        return request
    }
}
