//
//  Common.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import Foundation

public enum ErrorViewType {
    case toast
    case retry
}

/// LOADING
public protocol LoadingView {
    func display(_ viewModel: LoadingViewModel)
}

public struct LoadingViewModel {
    public let isLoading:Bool
}

/// ERROR
public protocol ErrorView {
    func display(_ viewModel: ErrorViewModel)
}

public struct ErrorViewModel {
    public let message: String?
    
    public let type:ErrorViewType
    
    static func toastError(message: String) -> ErrorViewModel {
        return ErrorViewModel(message: message, type: .toast)
    }
    
    static func retryError(message: String) -> ErrorViewModel {
        return ErrorViewModel(message: message, type: .retry)
    }
}

final class ErrorMapper {
    private init() {}
    
    static func map(_ error:Error, defaultMessage:String) -> String {
        switch error {
        case AppError.connectivity:
            return "No connectivity"
        case AppError.emptyData:
            return "No data"
        case AppError.invalidRequestData(let message):
            return message ?? "Invalid request data"
        case AppError.invalidResponseData(let message):
            return message ?? defaultMessage
        default:
            return defaultMessage
        }
    }
}
