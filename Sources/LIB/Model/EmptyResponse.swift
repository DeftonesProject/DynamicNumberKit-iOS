import Foundation

public struct EmptyResponse: Decodable {
    public let message: String
    enum CodingKeys: String, CodingKey {
        case message = "msg"
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
