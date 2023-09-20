//
//  URLBuilder.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

// интерфейс для построителя ссылок который отправляются на сервера
protocol URLBuilderType {
    func build(from providerRequest: Provider) -> URL
}

struct URLBuilder: URLBuilderType {
    func build(from providerRequest: Provider) -> URL {
        // для построения ссылки
        let components = providerRequest.params.map {
            URLQueryItem(name: $0.name, value: $0.value)
        }
        
        var urlComponents = URLComponents(url: providerRequest.baseURL, resolvingAgainstBaseURL: true)
        //записали парамеьтры
        //urlComponents?.queryItems = components
        return urlComponents?.url ?? providerRequest.baseURL
    }
}
