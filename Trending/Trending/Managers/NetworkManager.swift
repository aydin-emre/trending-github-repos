//
//  NetworkManager.swift
//  Trending
//
//  Created by Emre on 13.01.2023.
//

import Foundation
import Alamofire

final class NetworkManager {

    // MARK: - Initialization

    private init() {}
    static let shared = NetworkManager()

    // MARK: - Request

    func request<T: Decodable>(of type: T.Type,
                               for path: String,
                               method: HTTPMethod = .post,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: HTTPHeaders? = nil,
                               completion: @escaping (Decodable?, Error?) -> Void) {
        var inlineHeaders: HTTPHeaders = [:]
        inlineHeaders["Accept"] = "*/*"
        inlineHeaders["Content-Type"] = "application/x-www-form-urlencoded"

        if let headers = headers {
            for key in headers.dictionary.keys {
                inlineHeaders[key] = headers[key]
            }
        }

        var inlineParameters: Parameters = [:]

        if let parameters = parameters {
            for key in parameters.keys {
                inlineParameters[key] = parameters[key] as? String
            }
        }

        if let networkReachabilityManager = NetworkReachabilityManager(),
            networkReachabilityManager.isReachable {
            AF.request(NetworkPath.baseUrl+path,
                       method: method,
                       parameters: inlineParameters,
                       encoding: encoding,
                       headers: inlineHeaders)
                .validate(statusCode: 200..<400)
                .responseDecodable(of: type) { (response) in
                    switch response.result {
                    case .success(let value):
                        completion(value, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                }
        }
    }

    // MARK: - Webservices

    func searchRepositories(completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        request(of: SearchResponse.self,
                for: NetworkPath.searchRepositories,
                method: .get) { response, error in
            if let response = response as? SearchResponse {
                completion(.success(response))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

}
