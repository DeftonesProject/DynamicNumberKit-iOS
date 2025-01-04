import Foundation

public struct GetBalanceResponse: Decodable {
    public var balance: Int
    public var frozen: Int
}
