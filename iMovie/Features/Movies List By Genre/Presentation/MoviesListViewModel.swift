//
//  MoviesListViewModel.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public struct MoviesListViewModel {
    let movies:[Movie]
    let totalPages: Int
    let page:Int
}

public struct MovieViewModel {
    let id: Int
    let posterURL:URL
    let title: String
}
