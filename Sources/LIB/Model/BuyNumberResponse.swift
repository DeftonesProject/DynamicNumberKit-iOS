import Foundation

public struct BuyNumberResponse: Decodable {
    public var id: Int
    public var number: String
    public var info: BuyNumberInfo
}

public struct BuyNumberInfo: Decodable {
    public let credit: String
    public let retailPrice: String
    public let costPrice: String
    
    enum CodingKeys: String, CodingKey {
        case credit = "cost_cr"
        case retailPrice = "retail_rub"
        case costPrice = "cost_rub"
    }
}
