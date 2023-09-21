//
//  Movie.swift
//  Movies
//
//  Created by Влад Третьяк on 21.09.2023.
//

import Foundation

protocol Movie: Codable {
    var id: Int { get }
    var title: String { get }
    var posterPath: String? { get }
}
