//
//  GenreListRemoteLoader.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

let GENRE_LIST_URL = BASE_URL + "genre/movie/list"

final class GenreListRemoteLoader:GenreListLoader {
    private let client:BaseHttpClient
    
    typealias Result = GenreListLoader.Result
    
    public init(client:BaseHttpClient) {
        self.client = client
    }
    
    func loadGenreList(completion: @escaping (Result) -> Void) {
        let url = "\(GENRE_LIST_URL)?api_key=\(API_KEY)&language=en-US"
        debugPrint("URL \(url)")
        client.get(url, params: nil, headers: nil) { result in
            switch result {
            case let .success((data, response)):
                completion(GenreListRemoteLoader.map(data, response))
                 break
            case let .failure(error):
                completion(.failure(error))
                 break
            }
        }
    }
    
    private static func map(_ data:Data, _ response: HTTPURLResponse) -> Result {
        do {
            let result = try GenreListResponseMapper.map(data, response)
            return .success(result.toModels())
        }
        catch {
            return .failure(error)
        }
    }
}

private extension Array where Element == GenreItemResponse {
    func toModels() -> [Genre] {
        return map { Genre(id: $0.id ?? 0, name: $0.name ?? "") }
    }
}
