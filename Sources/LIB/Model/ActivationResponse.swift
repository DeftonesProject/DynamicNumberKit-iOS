import Foundation

public struct ActivationResponse: Decodable {
    public let activations: [Activation?]
    public let cursor: String?
}

public struct Activation: Decodable {
    public var pending: Bool
    public var codes: [Code]
    public let country: Country
    public let id: Int
    public let number: String
    public var insertedAt: String
    public let serviceId: String
    public var refunded: Bool
    
    public var status: ActivationStatusResponse.Status = .unknown

    enum CodingKeys: String, CodingKey {
        case pending
        case codes
        case country
        case id
        case number
        case insertedAt = "inserted_at"
        case serviceId = "service_id"
        case refunded
    }
    
    public init(pending: Bool, codes: [Code], country: Country, id: Int, number: String, insertedAt: String, serviceId: String, refunded: Bool) {
        self.pending = pending
        self.codes = codes
        self.country = country
        self.id = id
        self.number = number
        self.insertedAt = insertedAt
        self.serviceId = serviceId
        self.refunded = refunded
    }
}

public struct Code: Decodable {
    public let code: String
    public let id: Int
    public let text: String
    
    public init(code: String, id: Int, text: String) {
        self.code = code
        self.id = id
        self.text = text
    }
}

public struct Country: Decodable {
    public let countryId: Int
    public let flagUrl: String
    public let iso: String
    public let name: String

    enum CodingKeys: String, CodingKey {
        case countryId = "country_id"
        case flagUrl = "flag_url"
        case iso
        case name
    }
    
    public init(countryId: Int, flagUrl: String, iso: String, name: String) {
        self.countryId = countryId
        self.flagUrl = flagUrl
        self.iso = iso
        self.name = name
    }
}



