//
//  DiscoverListLoader.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public protocol DiscoverListLoader {
    typealias Result = Swift.Result<Discover, Error>
    func loadDiscoverList(genreId:Int, page:Int, completion: @escaping (Result) -> Void)
}
