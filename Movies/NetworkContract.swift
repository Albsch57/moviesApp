//
//  NetworkContract.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

enum NetworkErrorType: Error {
    case decoding, urlEncoding
}

struct NetworkParam: Encodable {
    let name: String
    let value: String
}

protocol NetworkClientType {
    func execute<Request: Provider, T: Decodable>(request: Request, with type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
