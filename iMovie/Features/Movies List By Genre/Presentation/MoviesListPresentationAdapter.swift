//
//  MoviesListPresentationAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class MoviesListPresentationAdapter: MoviesListCollectionViewControllerDelegate {
    private var page:Int = 1
    private var maxPage:Int = 0
    var presenter: MoviesListPresenter?
    private let genreId:Int
    private let remoteLoader: DiscoverListLoader
    
    init(remoteLoader: DiscoverListLoader, genreId:Int) {
        self.remoteLoader = remoteLoader
        self.genreId = genreId
    }
    
    func loadMovies(refresh: Bool) {
        remoteLoader.loadDiscoverList(genreId: genreId) {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.presenter?.didLoadMovies(MoviesListViewModel(movies: data.results.map { MovieViewModel(adult: $0.adult, backdropPath: $0.backdropPath, genreIDS: $0.genreIDS, id: $0.id, originalLanguage: $0.originalLanguage, originalTitle: $0.originalTitle, overview: $0.overview, popularity: $0.popularity, posterPath: $0.posterPath, releaseDate: $0.releaseDate, title: $0.title, video: $0.video, voteAverage: $0.voteAverage, voteCount: $0.voteCount)}, totalPages: data.totalPages, page: data.page))
            case .failure(let error):
                self.presenter?.didLoadMovies(with: error)
            }
        }
    }
}
