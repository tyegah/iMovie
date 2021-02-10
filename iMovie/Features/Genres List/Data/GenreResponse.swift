//
//  GenreResponse.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

// MARK: - GenreListResponse
struct GenreListResponse: Decodable {
    let genres: [GenreItemResponse]?
}

// MARK: - GenreItemResponse
struct GenreItemResponse: Decodable {
    let id: Int?
    let name: String?
}
