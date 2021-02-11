//
//  MovieDetailsRemoteLoader.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation
//https://api.themoviedb.org/3/movie/100?api_key=0fe1a635e8636a3e5fd62a3bf61f4f6e&language=en-US
let MOVIE_DETAILS_URL = BASE_URL + "movie/"

final class MovieDetailsRemoteLoader:MovieDetailsLoader {
    private let client:BaseHttpClient
    
    typealias Result = MovieDetailsLoader.Result
    
    public init(client:BaseHttpClient) {
        self.client = client
    }
    
    func loadMovieDetails(id:Int, completion: @escaping (Result) -> Void) {
        let url = "\(MOVIE_DETAILS_URL)\(id)?api_key=\(API_KEY)&language=en-US"
        debugPrint("URL \(url)")
        client.get(url, params: nil, headers: nil) { result in
            switch result {
            case let .success((data, response)):
                completion(MovieDetailsRemoteLoader.map(data, response))
                 break
            case let .failure(error):
                completion(.failure(error))
                 break
            }
        }
    }
    
    private static func map(_ data:Data, _ response: HTTPURLResponse) -> Result {
        do {
            let result = try MovieDetailsResponseMapper.map(data, response)
            return .success(result.toModel())
        }
        catch {
            return .failure(error)
        }
    }
}

extension MovieDetailsResponse {
    func toModel() -> MovieDetails {
        return MovieDetails(adult: self.adult ?? false,
                            backdropPath: self.backdropPath ?? "",
                            budget: self.budget ?? 0,
                            genres: (self.genres ?? []).map { Genre(id: $0.id ?? 0, name: $0.name ?? "") },
                            homepage: self.homepage ?? "",
                            id: self.id ?? 0,
                            imdbID: self.imdbID ?? "",
                            originalLanguage: self.originalLanguage ?? "",
                            originalTitle: self.originalTitle ?? "",
                            overview: self.overview ?? "",
                            popularity: self.popularity ?? 0,
                            posterPath: self.posterPath ?? "",
                            productionCompanies: (self.productionCompanies ?? []).map { $0.toModel() },
                            productionCountries: (self.productionCountries ?? []).map { $0.toModel() },
                            releaseDate: self.releaseDate ?? "",
                            revenue: self.revenue ?? 0,
                            runtime: self.runtime ?? 0,
                            spokenLanguages: (self.spokenLanguages ?? []).map { $0.toModel() },
                            status: self.status ?? "",
                            tagline: self.tagline ?? "",
                            title: self.title ?? "",
                            video: self.video ?? false,
                            voteAverage: self.voteAverage ?? 0,
                            voteCount: self.voteCount ?? 0)
    }
}

extension ProductionCompanyResponse {
    func toModel() -> ProductionCompany {
        return ProductionCompany(id: self.id ?? 0,
                                 logoPath: self.logoPath ?? "",
                                 name: self.name ?? "",
                                 originCountry: self.originCountry ?? "")
    }
}

extension ProductionCountryResponse {
    func toModel() -> ProductionCountry {
        return ProductionCountry(iso3166_1: self.iso3166_1 ?? "", name: self.name ?? "")
    }
}

extension SpokenLanguageResponse {
    func toModel() -> SpokenLanguage {
        return SpokenLanguage(englishName: self.englishName ?? "", iso639_1: self.iso639_1 ?? "", name: self.name ?? "")
    }
}
