//
//  MoviesListCollectionViewController.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import UIKit

private let reuseIdentifier = "Cell"

public protocol MoviesListCollectionViewControllerDelegate {
    func loadMovies(refresh:Bool)
}

public class MoviesListCollectionViewController: UICollectionViewController {
    public var delegate: MoviesListCollectionViewControllerDelegate?
    private var collectionModels = [CollectionCellController]() {
        didSet { collectionView.reloadData() }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate?.loadMovies(refresh: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView!.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 180, height: 250)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    private func cellController(forRowAt indexPath: IndexPath) -> CollectionCellController {
        return collectionModels[indexPath.row]
    }
    
    public func display(_ cellControllers: [CollectionCellController]) {
        collectionModels.append(contentsOf: cellControllers)
    }

    // MARK: UICollectionViewDataSource

    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModels.count
    }

    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellController(forRowAt: indexPath).view(in: collectionView, indexPath: indexPath)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension MoviesListCollectionViewController:LoadingView, ErrorView {
    public func display(_ viewModel: LoadingViewModel) {
        toggleLoadingView(viewModel.isLoading)
    }

    public func display(_ viewModel: ErrorViewModel) {
//        guard let message = viewModel.message else {
//            return
//        }
//
//        showRefreshView(self, onRetry: #selector(retry), message: message)
    }
}
