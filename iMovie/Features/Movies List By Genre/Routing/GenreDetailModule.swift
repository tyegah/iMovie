//
//  GenreDetailModule.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class GenreDetailModule {
    let router: GenreDetailRouter
    let viewController: MoviesListCollectionViewController

    init(_ viewModel:GenreViewModel) {
        let remoteLoader = DiscoverListRemoteLoader(client: URLSessionClient(session: URLSession.shared))
        let presentationAdapter = MoviesListPresentationAdapter(remoteLoader: MainQueueDispatchDecorator(decoratee: remoteLoader), genreId: viewModel.id)
        let router = GenreDetailRouter()
        let viewController = Storyboard.main().instantiateVC(MoviesListCollectionViewController.self) as! MoviesListCollectionViewController
        viewController.delegate = presentationAdapter
        router.viewController = viewController
        viewController.title = viewModel.name
        presentationAdapter.presenter = MoviesListPresenter(view: MoviesListViewAdapter(controller: viewController),
                                                                  loadingView: WeakRefVirtualProxy(viewController),
                                                                  errorView: WeakRefVirtualProxy(viewController),
                                                                  router: router)
        self.router = router
        self.viewController = viewController
    }
}
