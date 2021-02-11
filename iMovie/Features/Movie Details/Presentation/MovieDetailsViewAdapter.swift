//
//  MovieDetailsViewAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class MovieDetailsViewAdapter:MovieDetailsView {
    private weak var controller: MovieDetailsTableViewController?
    
    init(controller: MovieDetailsTableViewController) {
        self.controller = controller
    }
    
    /// CELL LOADER
    func display(_ viewModel: MovieDetailsViewModel) {
//        controller?.display(viewModel.movies.map({ item in
//            let adapter = MovieCellPresentationAdapter(model: item)
//            let view = MovieCellController(delegate: adapter)
//            adapter.presenter = MovieCellPresenter(view: WeakRefVirtualProxy(view), router: router)
//            return view
//        }))
    }
}
