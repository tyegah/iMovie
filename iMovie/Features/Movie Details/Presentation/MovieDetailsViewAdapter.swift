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
    func display(_ model: MovieDetails) {
        let adapter = MovieDetailsCellPresentationAdapter(model: model)
        let view = MovieDetailsCellController(delegate: adapter)
        adapter.presenter = MovieDetailsCellPresenter(view: WeakRefVirtualProxy(view))
        let controllers = [view]
        controller?.display(controllers)
    }
}
