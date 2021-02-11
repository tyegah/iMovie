//
//  MoviesListPresenter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public protocol MoviesListView {
    func display(_ viewModel: MoviesListViewModel, router: GenreDetailRouter)
}

final class MoviesListPresenter {
    private let view: MoviesListView
    private let loadingView: LoadingView
    private let errorView: ErrorView
    private let router: GenreDetailRouter
    
    init(view: MoviesListView, loadingView: LoadingView, errorView:ErrorView, router: GenreDetailRouter) {
        self.view = view
        self.loadingView = loadingView
        self.errorView = errorView
        self.router = router
    }
    
    func didStartLoadingGenre() {
        loadingView.display(LoadingViewModel(isLoading: true))
    }
    
    func didLoadMovies(with error:Error) {
        loadingView.display(LoadingViewModel(isLoading: false))
        let message = ErrorMapper.map(error, defaultMessage: "Failed to load Genre")
        errorView.display(ErrorViewModel.retryError(message: message))
    }
    
    func didLoadMovies(_ viewModel:MoviesListViewModel) {
        loadingView.display(LoadingViewModel(isLoading: false))
        view.display(viewModel, router: router)
    }
}
