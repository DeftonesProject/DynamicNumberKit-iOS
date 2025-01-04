public struct PriceModel: Decodable {
    public var credit: Int?
    
    enum CodingKeys: String, CodingKey {
        case credit = "cr"
    }
}
