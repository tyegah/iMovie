//
//  GenreListRouter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

protocol GenreDetailRoute {
    func onGenreClick(_ viewModel: GenreViewModel)
}

extension GenreDetailRoute where Self: RouterProtocol  {
    func onGenreClick(_ viewModel: GenreViewModel) {
        let module = GenreDetailModule(viewModel)
        let transition = PushTransition()
        module.router.openTransition = transition
        open(module.viewController, transition: transition)
    }
}

final public class GenreListRouter: Router<GenreListTableViewController>, GenreListRouter.Routes {
    typealias Routes = GenreDetailRoute
}
