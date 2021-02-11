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
            MovieViewModel(id: model.id, posterURL: model.posterURL!, title: model.title)
        )
    }
    
    public func didSelectMovie(for model:Movie) {
        router.onMovieClick(id: model.id)
    }
}
