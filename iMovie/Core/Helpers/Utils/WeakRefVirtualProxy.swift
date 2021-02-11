//
//  WeakRefVirtualProxy.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation
import UIKit

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: GenreCellView where T: GenreCellView {
    func display(_ viewModel: GenreViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: MovieCellView where T: MovieCellView {
    func display(_ viewModel: MovieViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: MovieDetailsCellView where T: MovieDetailsCellView {
    func display(_ viewModel: MovieDetailsViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: ErrorView where T: ErrorView {
    func display(_ viewModel: ErrorViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: LoadingView where T: LoadingView {
    func display(_ viewModel: LoadingViewModel) {
        object?.display(viewModel)
    }
}
