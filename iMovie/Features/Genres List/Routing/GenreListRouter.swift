//
//  GenreListRouter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

protocol GenreDetailRoute {
    func onGenreClick(id: Int)
}

extension GenreDetailRoute where Self: RouterProtocol  {
    func onGenreClick(id: Int) {

    }
}

final public class GenreListRouter: Router<GenreListTableViewController>, GenreListRouter.Routes {
    typealias Routes = GenreDetailRoute
}
