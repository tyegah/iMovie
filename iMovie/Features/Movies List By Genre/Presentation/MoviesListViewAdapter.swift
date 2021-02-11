//
//  MoviesListViewAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class MoviesListViewAdapter:MoviesListView {
    private weak var controller: MoviesListCollectionViewController?
    
    init(controller: MoviesListCollectionViewController) {
        self.controller = controller
    }
    
    /// CELL LOADER
    func display(_ viewModel: MoviesListViewModel, router: GenreDetailRouter) {
        if viewModel.totalPages == viewModel.page {
            controller?.hideFooter()
        }
        
        controller?.display(viewModel.movies.map({ item in
            let adapter = MovieCellPresentationAdapter(model: item)
            let view = MovieCellController(delegate: adapter)
            adapter.presenter = MovieCellPresenter(view: WeakRefVirtualProxy(view), router: router)
            return view
        }))
    }
}
