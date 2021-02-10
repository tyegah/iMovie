//
//  GenreListPresenter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public protocol GenreListView {
    func display(_ viewModel: GenreListViewModel, router: GenreListRouter)
}

final class GenreListPresenter {
    private let view: GenreListView
    private let loadingView: LoadingView
    private let errorView: ErrorView
    private let router: GenreListRouter
    
    init(view: GenreListView, loadingView: LoadingView, errorView:ErrorView, router: GenreListRouter) {
        self.view = view
        self.loadingView = loadingView
        self.errorView = errorView
        self.router = router
    }
    
    func didStartLoadingGenre() {
        loadingView.display(LoadingViewModel(isLoading: true))
    }
    
    func didLoadGenre(with error:Error) {
        loadingView.display(LoadingViewModel(isLoading: false))
        let message = ErrorMapper.map(error, defaultMessage: "Failed to load Genre")
        errorView.display(ErrorViewModel.retryError(message: message))
    }
    
    func didLoadGenre(_ viewModel:GenreListViewModel) {
        loadingView.display(LoadingViewModel(isLoading: false))
        view.display(viewModel, router: router)
    }
}
