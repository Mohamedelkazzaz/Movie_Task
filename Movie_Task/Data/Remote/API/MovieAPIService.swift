//
//  MovieAPIService.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 14/07/2025.
//

import Foundation
import Alamofire


final class APIClient {
    static let shared = APIClient()
    private init() {}

    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "d40b173a39cc55ab4ad2f1bf996b8bb8"

    func request<T: Decodable>(_ endpoint: String,
                                parameters: Parameters? = nil,
                                completion: @escaping (Result<T, Error>) -> Void) {
        var params = parameters ?? [:]
        params["api_key"] = apiKey

        let url = baseURL + endpoint

        print(url)
        
        AF.request(url, parameters: params).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
