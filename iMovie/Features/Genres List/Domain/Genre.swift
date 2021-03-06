//
//  GenreItem.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

// MARK: - GenreList
public struct GenreList: Equatable {
    let genres: [Genre]
}

// MARK: - Genre
public struct Genre: Equatable {
    let id: Int
    let name: String
}
