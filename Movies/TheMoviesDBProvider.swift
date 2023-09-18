//
//  TheMoviesDBProvider.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

// типа репозитория только для нетворкинга
enum MoviesDBProvider: Provider {
    
    case searchMovies(query: String)
    case movies
    
    var baseURL: URL {
        switch self {
        case .movies:
          return URL(string: "https://api.themoviedb.org/3/discover/movie")!
        case .searchMovies(query: _):
           return URL(string: "https://api.themoviedb.org/3/search/movie")!
        }
    }
    
    var params: [NetworkParam] {
        switch self {
        case .movies:
            return [
                NetworkParam(name: "include_adult", value: "false"),
                NetworkParam(name: "include_video", value: "false"),
                NetworkParam(name: "language", value: "en-US"),
                NetworkParam(name: "page", value: "1"),
                NetworkParam(name: "sort_by", value: "popularity.desc")
            ]
        case .searchMovies(query: let query):
            return [
                NetworkParam(name: "query", value: query),
                NetworkParam(name: "include_adult", value: "false"),
                NetworkParam(name: "language", value: "en-US"),
                NetworkParam(name: "primary_release_year", value: ""),
                NetworkParam(name: "page", value: "1"),
                NetworkParam(name: "region", value: ""),
                NetworkParam(name: "year", value: "")
            ]
        }
    }
    
    
}

