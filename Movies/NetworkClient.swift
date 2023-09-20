//
//  NetworkClient.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation
import Alamofire

final class NetworkClient: NetworkClientType {
    
    private let urlBuilder: URLBuilderType
    
    init(urlBuilder: URLBuilderType) {
        self.urlBuilder = urlBuilder
    }
    
    func execute<Request, T>(request: Request, with type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where Request : Provider, T : Decodable {
        let url = urlBuilder.build(from: request)
        let params = Dictionary(uniqueKeysWithValues: request.params.map { ($0.name, $0.value) })

        let headers: HTTPHeaders = [.authorization(bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NGNhN2NlNzY3YmJiZWI5M2NiM2YwNjFjNTBlZmU3OCIsInN1YiI6IjY1MDg2MGQ0ZmEyN2Y0MDBjYWE1MGM1ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WQO2Ytm4V4SCky_6p3StAcgd0BP6baGwwnnPwij8XLs")]
        
        AF.request(url, method: .get, parameters: params,  headers: headers)
            .responseDecodable(of: type) { response in
                switch response.result {
                case .success(let responseModel):
                    completion(.success(responseModel))
                case .failure(let error):
                    print(response.error)
                    completion(.failure(error))
                }
            }
    }
    
}
