import Foundation

public struct RequestDetails {
    public let target: Any
    public let responseClass: Any
}

public enum NetworkError: Error {
    case timeout(RequestDetails)
    case other(Error)
    case noInternetConnection(RequestDetails)
}

public protocol NetworkErrorHandler: AnyObject {
    func handleNetworkError(_ error: NetworkError, successAction: (() -> Void)?)
}
