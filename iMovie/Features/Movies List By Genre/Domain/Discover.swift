//
//  Discover.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

// MARK: - Discover
public struct Discover: Equatable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

// MARK: - Result
public struct Movie: Equatable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var posterURL:URL? {
        return URL(string:"https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
