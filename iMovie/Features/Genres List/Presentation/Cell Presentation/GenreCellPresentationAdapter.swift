//
//  GenreCellPresentationAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation
import UIKit

public protocol GenreCellControllerDelegate {
    func loadGenreItem()
    func didSelectGenre()
}

public class GenreCellPresentationAdapter: GenreCellControllerDelegate {
    private let model: Genre
    var presenter: GenreCellPresenter?
    
    init(model: Genre) {
        self.model = model
    }
    
    public func didSelectGenre() {
        presenter?.didSelectGenre(for: model)
    }
    
    public func loadGenreItem() {
        presenter?.loadGenreItem(for: model)
    }
    
}

public final class GenreCellController: GenreCellView, CellController {
    private var cell: GenreTableViewCell?
    private let delegate:GenreCellControllerDelegate
    
    public init(delegate: GenreCellControllerDelegate) {
        self.delegate = delegate
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        delegate.loadGenreItem()
        return cell!
    }
    
    public func display(_ viewModel: GenreViewModel) {
        cell?.genreLabel.text = viewModel.name
    }
    
    public func didSelectCell() {
        delegate.didSelectGenre()
    }
}
