//
//  GenreListViewAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class GenreListViewAdapter:GenreListView {
    private weak var controller: GenreListTableViewController?
    
    init(controller: GenreListTableViewController) {
        self.controller = controller
    }
    
    /// CELL LOADER
    func display(_ viewModel: GenreListViewModel, router: GenreListRouter) {
        controller?.display(viewModel.genres.map { genre in
                let adapter = GenreCellPresentationAdapter(model: genre)
                let view = GenreCellController(delegate: adapter)
                adapter.presenter = GenreCellPresenter(view: WeakRefVirtualProxy(view), router: router)
                return view
            }
        )
    }
}
