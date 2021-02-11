//
//  MoviesListCollectionViewController.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import UIKit

private let reuseIdentifier = "Cell"

public protocol MoviesListCollectionViewControllerDelegate {
    func loadMovies(refresh:Bool, isNextPage:Bool)
}

public class MoviesListCollectionViewController: UICollectionViewController {
    private var shouldShowFooter:Bool = true
    public var delegate: MoviesListCollectionViewControllerDelegate?
    private var collectionModels = [CollectionCellController]() {
        didSet { collectionView.reloadData() }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate?.loadMovies(refresh: true, isNextPage: false)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        collectionView!.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterCollectionReusableView")
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 180, height: 250)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        layout.footerReferenceSize = CGSize(width: self.view.frame.width, height: 60)
        // Do any additional setup after loading the view.
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> CollectionCellController {
        return collectionModels[indexPath.row]
    }
    
    public func display(_ cellControllers: [CollectionCellController]) {
        collectionModels.append(contentsOf: cellControllers)
    }
    
    public func hideFooter() {
        shouldShowFooter = false
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
    
    override public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionModels.count - 1 {  //numberofitem count
            delegate?.loadMovies(refresh: false, isNextPage: true)
        }
    }
    
    public override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter && shouldShowFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterCollectionReusableView", for: indexPath)
            let loading = UIActivityIndicatorView()
            loading.style = .gray
            loading.tintColor = UIColor.gray
            loading.tag = 111
            footerView.addSubview(loading)
            loading.center = footerView.center
            loading.startAnimating()
            return footerView
        }
        
        fatalError("Unexpected element kind")
    }
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
