//
//  ProviderContract.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

protocol Provider {
    var baseURL: URL { get }
    var params: [NetworkParam] { get }
}

