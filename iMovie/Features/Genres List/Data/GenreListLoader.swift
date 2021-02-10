//
//  GenreListLoader.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

public protocol GenreListLoader {
    typealias Result = Swift.Result<[Genre], Error>
    func loadGenreList(completion: @escaping (Result) -> Void)
}
