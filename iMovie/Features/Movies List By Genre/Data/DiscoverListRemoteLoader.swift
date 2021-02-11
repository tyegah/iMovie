//
//  DiscoverListRemoteLoader.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

let DISCOVER_LIST_URL = BASE_URL + "discover/movie"

final class DiscoverListRemoteLoader:DiscoverListLoader {
    private let client:BaseHttpClient
    
    typealias Result = DiscoverListLoader.Result
    
    public init(client:BaseHttpClient) {
        self.client = client
    }
    
    func loadDiscoverList(genreId:Int, completion: @escaping (Result) -> Void) {
        let url = "\(DISCOVER_LIST_URL)?api_key=\(API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_Discovers=\(genreId)"
        debugPrint("URL \(url)")
        client.get(url, params: nil, headers: nil) { result in
            switch result {
            case let .success((data, response)):
                completion(DiscoverListRemoteLoader.map(data, response))
                 break
            case let .failure(error):
                completion(.failure(error))
                 break
            }
        }
    }
    
    private static func map(_ data:Data, _ response: HTTPURLResponse) -> Result {
        do {
            let result = try DiscoverListResponseMapper.map(data, response)
            return .success(result.toModel())
        }
        catch {
            return .failure(error)
        }
    }
}

extension DiscoverResponse {
    func toModel() -> Discover {
        return Discover(page: self.page ?? 0, results: (self.results ?? []).map {$0.toModel()}, totalPages: self.totalPages ?? 0, totalResults: self.totalResults ?? 0)
    }
}

extension MovieResponse {
    func toModel() -> Movie {
        return Movie(adult: self.adult ?? false, backdropPath: self.backdropPath ?? "", genreIDS: self.genreIDS ?? [], id: self.id ?? 0, originalLanguage: self.originalLanguage ?? "N/A", originalTitle: self.originalTitle ?? "", overview: self.overview ?? "Not available", popularity: self.popularity ?? 0, posterPath: self.posterPath ?? "", releaseDate: self.releaseDate ?? "", title: self.title ?? "", video: self.video ?? false, voteAverage: self.voteAverage ?? 0, voteCount: self.voteCount ?? 0)
    }
}
