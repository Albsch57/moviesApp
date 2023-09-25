//
//  URLBuilder.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

protocol URLBuilderType {
    func build(from providerRequest: Provider) -> URL
}

struct URLBuilder: URLBuilderType {
    func build(from providerRequest: Provider) -> URL {
       
        let components = providerRequest.params.map {
            URLQueryItem(name: $0.name, value: $0.value)
        }
        
        var urlComponents = URLComponents(url: providerRequest.baseURL, resolvingAgainstBaseURL: true)
       
        return urlComponents?.url ?? providerRequest.baseURL
    }
}
