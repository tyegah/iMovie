//
//  MovieDetailsCellPresentationAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

import UIKit
import Kingfisher

public class MovieDetailsCellPresentationAdapter: MovieDetailsCellControllerDelegate {

    private let model: MovieDetails
    var presenter: MovieDetailsCellPresenter?
    
    init(model: MovieDetails) {
        self.model = model
    }
    
    public func loadMovieDetails() {
        presenter?.loadDetails(for: model)
    }
    
}

public protocol MovieDetailsCellControllerDelegate {
    func loadMovieDetails()
}

public final class MovieDetailsCellController: MovieDetailsCellView, CellController {
    private var cell: MovieDetailsTableViewCell?
    private let delegate:MovieDetailsCellControllerDelegate
    
    public init(delegate: MovieDetailsCellControllerDelegate) {
        self.delegate = delegate
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        delegate.loadMovieDetails()
        return cell!
    }
    
    
    public func display(_ viewModel: MovieDetailsViewModel) {
        cell?.movieTitleLabel.text = viewModel.title
        cell?.imgView.kf.setImage(with: viewModel.posterURL)
        cell?.genreLabel.text = "\(viewModel.genres) . \(viewModel.duration)"
        cell?.overviewLabel.text = viewModel.overview
        cell?.ratingLabel.text = viewModel.rating
        cell?.releaseDateLabel.text = viewModel.releaseDate
    }
    
    public func didSelectCell() {
        
    }
}
