//
//  GenreCellPresenter.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public class GenreCellPresenter {
    private let view: GenreCellView
    private let router: GenreListRouter
    
    init(view: GenreCellView, router: GenreListRouter) {
        self.view = view
        self.router = router
    }
    
    public func loadGenreItem(for model:Genre) {
        view.display(
            GenreViewModel(
                id:model.id,
                name: model.name
            )
        )
    }
    
    public func didSelectGenre(for model:Genre) {
        router.onGenreClick(GenreViewModel(id: model.id, name: model.name))
    }
}
