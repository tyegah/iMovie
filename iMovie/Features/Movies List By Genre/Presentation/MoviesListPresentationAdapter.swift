//
//  MoviesListPresentationAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class MoviesListPresentationAdapter: MoviesListCollectionViewControllerDelegate {
    private var page:Int = 1
    var presenter: MoviesListPresenter?
    private let genreId:Int
    private let remoteLoader: DiscoverListLoader
    
    init(remoteLoader: DiscoverListLoader, genreId:Int) {
        self.remoteLoader = remoteLoader
        self.genreId = genreId
    }
    
    func loadMovies(refresh: Bool, isNextPage:Bool) {
        page = isNextPage && !refresh ? page + 1 : page
        remoteLoader.loadDiscoverList(genreId: genreId, page: page) {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.presenter?.didLoadMovies(MoviesListViewModel(movies: data.results, totalPages: data.totalPages, page: data.page))
            case .failure(let error):
                self.presenter?.didLoadMovies(with: error)
            }
        }
    }
}
