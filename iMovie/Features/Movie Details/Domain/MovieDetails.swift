//
//  MovieDetails.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

// MARK: - MovieDetails
public struct MovieDetails: Equatable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var posterURL:URL? {
        return URL(string:"https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    var backdropURL:URL? {
        return URL(string:"https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
}

// MARK: - ProductionCompany
public struct ProductionCompany: Equatable {
    let id: Int
    let logoPath: String
    let name, originCountry: String
}

// MARK: - ProductionCountry
public struct ProductionCountry: Equatable {
    let iso3166_1, name: String
}

// MARK: - SpokenLanguage
public struct SpokenLanguage: Equatable {
    let englishName, iso639_1, name: String
}
