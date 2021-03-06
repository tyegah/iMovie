//
//  CellController.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import UIKit

public protocol CollectionCellController {
    func view(in collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func didSelectCell()
}

public protocol CellController {
    func view(in tableView: UITableView) -> UITableViewCell
    func didSelectCell()
}
