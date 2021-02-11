//
//  MoviesListViewModel.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public struct MoviesListViewModel {
    let movies:[Movie]
    let totalPages: Int
    let page:Int
}

public struct MovieViewModel {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterURL:URL
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
