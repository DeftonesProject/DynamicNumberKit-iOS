import Foundation

public struct CreateAccountResponse: Decodable {
    public let token: String
    public let id: Int
}
