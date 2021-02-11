//
//  MovieCellPresenter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public class MovieCellPresenter {
    private let view: MovieCellView
    private let router: GenreDetailRouter
    
    init(view: MovieCellView, router: GenreDetailRouter) {
        self.view = view
        self.router = router
    }
    
    public func loadMovieItem(for model:Movie) {
        view.display(
            MovieViewModel(adult: model.adult, backdropPath: model.backdropPath, genreIDS: model.genreIDS, id: model.id, originalLanguage: model.originalLanguage, originalTitle: model.originalTitle, overview: model.overview, popularity: model.popularity, posterPath: model.posterPath, releaseDate: model.releaseDate, title: model.title, video: model.video, voteAverage: model.voteAverage, voteCount: model.voteCount)
        )
    }
    
    public func didSelectMovie(for model:Movie) {
        
    }
}
