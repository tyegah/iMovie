//
//  MovieDetailsPresentationAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class MovieDetailsPresentationAdapter: MovieDetailsTableViewControllerDelegate {
    var presenter: MovieDetailsPresenter?
    private let movieId:Int
    private let remoteLoader: MovieDetailsLoader
    
    init(remoteLoader: MovieDetailsLoader, movieId:Int) {
        self.remoteLoader = remoteLoader
        self.movieId = movieId
    }
    
    func loadMovieDetails(refresh: Bool) {
        remoteLoader.loadMovieDetails(id: movieId) {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.presenter?.didLoadMovieDetails(MovieDetailsViewModel(genres: data.genres.map {$0.name}, id: data.id, overview: data.overview, posterURL: data.posterURL, releaseDate: "", title: data.title, rating: "Rating : \(data.voteAverage)/10", duration: "\(data.runtime) minutes"))
            case .failure(let error):
                self.presenter?.didLoadMovieDetails(with: error)
            }
        }
    }
}
