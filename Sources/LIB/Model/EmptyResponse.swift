import Foundation

public struct EmptyResponse: Decodable {
    public let message: String
    let status: String?
    enum CodingKeys: String, CodingKey {
        case message = "msg"
        case status
    }
}

extension EmptyResponse: CustomStringConvertible {
    public var description: String {
        jsonFormatDescription((name: "message", value: message))
    }
}
public struct ErrorResponse: Decodable {
    public let error: String
}

extension ErrorResponse: CustomStringConvertible {
    public var description: String {
        jsonFormatDescription((name: "error", value: error))
    }
}
