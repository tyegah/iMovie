//
//  ImageDataLoader.swift
//  PokeApp
//
//  Created by UN A on 12/11/20.
//

import Foundation

public protocol PokemonDetailLoaderTask {
    func cancel()
}

public protocol ImageDataLoaderTask {
    func cancel()
}

public protocol ImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> ImageDataLoaderTask
}
