//
//  MovieDetailsCellPresenter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public class MovieDetailsCellPresenter {
    private let view: MovieDetailsCellView
    
    init(view: MovieDetailsCellView) {
        self.view = view
    }
    
    public func loadDetails(for model:MovieDetails) {
        let genres = model.genres.map { $0.name }.joined(separator: ", ")
        view.display(
            MovieDetailsViewModel(genres: genres, id: model.id, overview: model.overview, posterURL: model.backdropURL, releaseDate: "Release Date \(model.releaseDate)", title: model.title, rating: "Rating \(model.voteAverage)/10", duration: "\(model.runtime) minutes")
        )
    }
}
