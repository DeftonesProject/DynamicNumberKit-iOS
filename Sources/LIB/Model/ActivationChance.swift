import Foundation

public struct ActivationChance: Decodable {
    public var type: ActivationChanceType
    public var successPercent: Int?

    
    enum CodingKeys: String, CodingKey {
        case type
        case successPercent = "success_pct"
    }
}
