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

    }
}
