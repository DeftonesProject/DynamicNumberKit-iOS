import Foundation

public struct CountryModel: Decodable {
    public var name: String
    public var price: Int
    public var countyCode: String
    public var flagURLString: String
    public var popular: Bool
    public var countryID: Int
    public var availableNumberCount: Int
    public var activationChance: ActivationChance?
    
    enum CodingKeys: String, CodingKey {
        case name, popular
        case price = "price_cr"
        case countyCode = "iso"
        case flagURLString = "flag_url"
        case countryID = "country_id"
        case availableNumberCount = "numbers_available"
        case activationChance = "activation_chance"
    }
}
