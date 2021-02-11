//
//  DiscoverListResponseMapper.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation


final class DiscoverListResponseMapper {
    static func map(_ data: Data,_ response: HTTPURLResponse) throws -> DiscoverResponse {
                 let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                print("RESPONSE \(json)")
        
        var remoteData:DiscoverResponse? = nil
        do {
            remoteData = try JSONDecoder().decode(DiscoverResponse.self, from: data)
        } catch {
            throw AppError.invalidResponseData("Invalid response data")
        }
        
        guard response.statusCode == HTTP_STATUS_OK, let dt = remoteData else {
            throw AppError.emptyData
        }
        
        return dt
    }
}
