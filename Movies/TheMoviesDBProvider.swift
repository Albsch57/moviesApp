//
//  TheMoviesDBProvider.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

// типа репозитория только для нетворкинга
enum MoviesDBProvider: Provider {
    
    case searchMovies(query: String, page: Int)
    case movies(page: Int, sorted: SortState = .descending)
    
    var baseURL: URL {
        switch self {
        case .movies(page: _):
          return URL(string: "https://api.themoviedb.org/3/discover/movie")!
        case .searchMovies(query: _):
           return URL(string: "https://api.themoviedb.org/3/search/movie")!
        }
    }
    
    var cdnURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w500")!
    }
    
    var params: [NetworkParam] {
        switch self {
        case .movies(let pageNumber, let sorted):
            return [
                NetworkParam(name: "include_adult", value: "false"),
                NetworkParam(name: "include_video", value: "false"),
                NetworkParam(name: "language", value: "en-US"),
                NetworkParam(name: "page", value: "\(pageNumber)"),
                NetworkParam(name: "sort_by", value: "popularity.\(sorted.rawValue)")
            ]
        case .searchMovies(query: let query, page: let page):
            return [
                NetworkParam(name: "query", value: query),
                NetworkParam(name: "include_adult", value: "false"),
                NetworkParam(name: "language", value: "en-US"),
                NetworkParam(name: "primary_release_year", value: ""),
                NetworkParam(name: "page", value: "\(page)"),
                NetworkParam(name: "region", value: ""),
                NetworkParam(name: "year", value: "")
            ]
        }
    }
    
    
}

