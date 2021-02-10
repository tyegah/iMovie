//
//  GenreListTableViewController.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import UIKit

public protocol GenreListTableViewControllerDelegate {
    func loadGenres(refresh:Bool)
}

public class GenreListTableViewController: UITableViewController {
    public var delegate: GenreListTableViewControllerDelegate?
    private var tableModel = [CellController]() {
        didSet { tableView.reloadData() }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refresh(true)
    }
    
    // MARK: - Helper
    @objc func refresh(_ refresh:Bool) {
        delegate?.loadGenres(refresh: refresh)
    }
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "iMovie"
        tableView.registerCell(GenreTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> CellController {
        return tableModel[indexPath.row]
    }
    
    public func display(_ cellControllers: [CellController]) {
        tableModel.append(contentsOf: cellControllers)
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
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = tableModel[indexPath.row]
        controller.didSelectCell()
    }
    
    override public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (tableModel.count - 1) {
            animateFooter(false)
        }
    }
    
    override public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        animateFooter(true)
    }
    
    private func animateFooter(_ refresh:Bool) {
        showFooterActivityView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if refresh {
                self.refresh(false)
            }
            self.hideFooterActivityView()
        }
    }
    
    private func hideFooterActivityView() {
        self.tableView.tableFooterView?.isHidden = true
    }
    
    private func showFooterActivityView() {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat.zero, y: CGFloat.zero, width: tableView.bounds.width, height: CGFloat(44.0))

        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    
    @objc private func retry() {
        refresh(true)
    }
}

extension GenreListTableViewController:LoadingView, ErrorView {
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
