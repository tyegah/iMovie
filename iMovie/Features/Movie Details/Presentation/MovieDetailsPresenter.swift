//
//  MovieDetailsPresenter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class MovieDetailsPresenter {
    private let view: MovieDetailsView
    private let loadingView: LoadingView
    private let errorView: ErrorView
    
    init(view: MovieDetailsView, loadingView: LoadingView, errorView:ErrorView) {
        self.view = view
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    func didStartLoadingGenre() {
        loadingView.display(LoadingViewModel(isLoading: true))
    }
    
    func didLoadMovieDetails(with error:Error) {
        loadingView.display(LoadingViewModel(isLoading: false))
        let message = ErrorMapper.map(error, defaultMessage: "Failed to load Movie Details")
        errorView.display(ErrorViewModel.retryError(message: message))
    }
    
    func didLoadMovieDetails(_ model:MovieDetails) {
        loadingView.display(LoadingViewModel(isLoading: false))
        view.display(model)
    }
}
