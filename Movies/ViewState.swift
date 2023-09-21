//
//  ViewState.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import Foundation

enum ViewState<T> {
    case loading
    case data(rows: [T], page: Int)
    case movie(T)
    case error(massage: String)
}
