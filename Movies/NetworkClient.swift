//
//  NetworkClient.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

final class NetworkClient: NetworkClientType {
    
    private let urlBuilder: URLBuilderType
    
    init(urlBuilder: URLBuilderType) {
        self.urlBuilder = urlBuilder
    }
    
    func execute<Request, T>(request: Request, with type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where Request : Provider, T : Decodable {
        let url = urlBuilder.build(from: request)
        print("Starting request \(url.absoluteString)")
    }
    
}
