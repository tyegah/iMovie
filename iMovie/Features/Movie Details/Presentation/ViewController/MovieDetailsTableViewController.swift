//
//  MovieDetailsTableViewController.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import UIKit

public protocol MovieDetailsTableViewControllerDelegate {
    func loadMovieDetails(refresh:Bool)
}

public class MovieDetailsTableViewController: UITableViewController {
    public var delegate: MovieDetailsTableViewControllerDelegate?
    private var tableModel = [CellController]() {
        didSet { tableView.reloadData() }
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        delegate?.loadMovieDetails(refresh: true)
    }
    
    private func setupUI() {
        tableView.registerCell(MovieDetailsTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> CellController {
        return tableModel[indexPath.row]
    }
    
    public func display(_ cellControllers: [CellController]) {
        tableModel = cellControllers
    }
    
    // MARK: - Table view data source
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view(in: tableView)
    }
    
    @objc private func retry() {
        delegate?.loadMovieDetails(refresh: true)
    }
}

extension MovieDetailsTableViewController:LoadingView, ErrorView {
    public func display(_ viewModel: LoadingViewModel) {
        toggleLoadingView(viewModel.isLoading)
    }
    
    public func display(_ viewModel: ErrorViewModel) {
        guard let message = viewModel.message else {
            return
        }
        
        showRefreshView(self, onRetry: #selector(retry), message: message)
    }
}
