import Foundation

public struct ServiceModel: Decodable, Identifiable {
    public var count: Int?
    public var id: String
    public var title: String
    public var iconUrlString: String
    public var popular: Bool
    public var minPrice: PriceModel?
    
    enum CodingKeys: String, CodingKey {
        case count, id, title, popular
        case iconUrlString = "icon_url"
        case minPrice = "min_price"
    }
}


