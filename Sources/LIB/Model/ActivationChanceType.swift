import Foundation

public enum ActivationChanceType: String, Decodable {
    case veryLow = "very low"
    case low = "low"
    case medium = "medium"
    case high = "high"
    case veryHigh = "very high"
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        if let type = ActivationChanceType(rawValue: rawValue) {
            self = type
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown type value: \(rawValue)")
        }
    }
}
