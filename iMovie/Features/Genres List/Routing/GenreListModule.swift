//
//  GenreListModule.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    func main() -> UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
}

final class GenreListModule {
    let router: GenreListRouter
    let viewController: GenreListTableViewController

    init() {
        let remoteLoader = GenreListRemoteLoader(client: URLSessionClient(session: URLSession.shared))
        let presentationAdapter = GenreListPresentationAdapter(remoteLoader: MainQueueDispatchDecorator(decoratee: remoteLoader))
        let router = GenreListRouter()
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"GenreListTableViewController") as! GenreListTableViewController
        viewController.delegate = presentationAdapter
        router.viewController = viewController
        presentationAdapter.presenter = GenreListPresenter(view: GenreListViewAdapter(controller: viewController),
                                                                  loadingView: WeakRefVirtualProxy(viewController),
                                                                  errorView: WeakRefVirtualProxy(viewController),
                                                                  router: router)
        self.router = router
        self.viewController = viewController
    }
}
