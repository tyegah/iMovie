//
//  GenreListPresentationAdapter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class GenreListPresentationAdapter: GenreListTableViewControllerDelegate {
    private let itemsPerPage:Int = 10
    private var page:Int = 1
    private var maxPage:Int = 1
    var presenter: GenreListPresenter?
    private var genres:[Genre] = []
    private let remoteLoader: GenreListLoader
    
    init(remoteLoader: GenreListLoader) {
        self.remoteLoader = remoteLoader
    }
    
    func loadGenres(refresh: Bool) {
        if genres.count > 0 && !refresh {
            if page < maxPage {
                page = page + 1
                var count = page * itemsPerPage
                count = count > genres.count ? genres.count : count
                let items = genres.prefix(count).dropFirst((page-1) * itemsPerPage)
                self.presenter?.didLoadGenre(GenreListViewModel(genres: Array(items)))
            }
        }
        else {
            self.loadGenresFromRemote()
        }
    }
    
    
    func loadGenresFromRemote() {
        self.presenter?.didStartLoadingGenre()
        remoteLoader.loadGenreList {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.genres = data
                let max = ceil(Double(data.count)/Double(self.itemsPerPage))
                self.maxPage = Int(max)
                self.presenter?.didLoadGenre(GenreListViewModel(genres: Array(data.prefix(10))))
            case .failure(let error):
                self.presenter?.didLoadGenre(with: error)
            }
        }
    }
}
