//
//  MovieDetailsModule.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class MovieDetailsModule {
    let router: MovieDetailsRouter
    let viewController: MovieDetailsTableViewController

    init(_ id:Int) {
        let remoteLoader = MovieDetailsRemoteLoader(client: URLSessionClient(session: URLSession.shared))
        let presentationAdapter = MovieDetailsPresentationAdapter(remoteLoader: MainQueueDispatchDecorator(decoratee: remoteLoader), movieId: id)
        let router = MovieDetailsRouter()
        let viewController = Storyboard.main().instantiateVC(MovieDetailsTableViewController.self) as! MovieDetailsTableViewController
        viewController.delegate = presentationAdapter
        router.viewController = viewController
        presentationAdapter.presenter = MovieDetailsPresenter(view: MovieDetailsViewAdapter(controller: viewController),
                                                                  loadingView: WeakRefVirtualProxy(viewController),
                                                                  errorView: WeakRefVirtualProxy(viewController))
        self.router = router
        self.viewController = viewController
    }
}
