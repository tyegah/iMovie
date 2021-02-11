//
//  GenreDetailRouter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

protocol MovieDetailRoute {
    func onMovieClick(id: Int)
}

extension MovieDetailRoute where Self: RouterProtocol  {
    func onMovieClick(id: Int) {

    }
}


final public class GenreDetailRouter: Router<MoviesListCollectionViewController>, GenreDetailRouter.Routes {
    typealias Routes = MovieDetailRoute
}
