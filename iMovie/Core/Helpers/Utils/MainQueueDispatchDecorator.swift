//
//  MainQueueDispatchDecorator.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        
        completion()
    }
}

extension MainQueueDispatchDecorator: GenreListLoader where T == GenreListLoader {
    func loadGenreList(completion: @escaping (GenreListLoader.Result) -> Void) {
        decoratee.loadGenreList { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchDecorator: DiscoverListLoader where T == DiscoverListLoader {
    func loadDiscoverList(genreId: Int,page:Int, completion: @escaping (DiscoverListLoader.Result) -> Void) {
        decoratee.loadDiscoverList(genreId: genreId, page:page) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchDecorator: MovieDetailsLoader where T == MovieDetailsLoader {
    func loadMovieDetails(id: Int, completion: @escaping (MovieDetailsLoader.Result) -> Void) {
        decoratee.loadMovieDetails(id: id) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
