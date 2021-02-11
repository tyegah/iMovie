//
//  MovieCellPresentationAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation
import UIKit

public class MovieCellPresentationAdapter: MovieCellControllerDelegate {
    private let model: Movie
    var presenter: MovieCellPresenter?
    
    init(model: Movie) {
        self.model = model
    }
    
    public func didSelectMovie() {
        presenter?.didSelectMovie(for: model)
    }
    
    public func loadMovieItem() {
        presenter?.loadMovieItem(for: model)
    }
    
}

public protocol MovieCellControllerDelegate {
    func loadMovieItem()
    func didSelectMovie()
}

public final class MovieCellController: MovieCellView, CollectionCellController {
    private var cell: MovieCollectionViewCell?
    private let delegate:MovieCellControllerDelegate
    
    public init(delegate: MovieCellControllerDelegate) {
        self.delegate = delegate
    }
    
    public func view(in collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        cell = collectionView.dequeueReusableCell(for: indexPath)
        delegate.loadMovieItem()
        return cell!
    }
    
    public func display(_ viewModel: MovieViewModel) {
        cell?.titleLabel.text = viewModel.title
    }
    
    public func didSelectCell() {
        delegate.didSelectMovie()
    }
}
