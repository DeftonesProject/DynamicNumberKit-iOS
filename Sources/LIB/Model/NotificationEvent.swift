import Foundation

public enum NotificationEvent: String, Decodable {
    case activationRefund = "ACTIVATION_REFUND"
    case activationCode = "ACTIVATION_CODE"
    case unknown
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = NotificationEvent(rawValue: rawValue) ?? .unknown
    }
}

public struct PushNotification: Decodable {
    public let aps: APS
    public let event: NotificationEvent
    
    public let balance: Int?
    public let change: Int?
    public let activationID: Int?
    public let code: String?
    public let number: String?
    public let text: String?
    
    enum CodingKeys: String, CodingKey {
        case change, balance, code, number,text, aps, event
        case activationID = "activation_id"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.change = try container.decodeIfPresent(Int.self, forKey: .change)
        self.balance = try container.decodeIfPresent(Int.self, forKey: .balance)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.aps = try container.decode(APS.self, forKey: .aps)
        self.event = try container.decode(NotificationEvent.self, forKey: .event)
        self.activationID = try container.decodeIfPresent(Int.self, forKey: .activationID)
    }
    
    public init(aps: APS, event: NotificationEvent, balance: Int?, change: Int?, activationID: Int?, code: String?, number: String?, text: String?) {
        self.aps = aps
        self.event = event
        self.balance = balance
        self.change = change
        self.activationID = activationID
        self.code = code
        self.number = number
        self.text = text
    }
}

public struct APS: Decodable {
    public let alert: Alert?
    public let contentAvailable: Int?
    public let mutableContent: Int?
    public let sound: String?
    
    enum CodingKeys: String, CodingKey {
        case alert
        case contentAvailable = "content-available"
        case mutableContent = "mutable-content"
        case sound
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.alert = try container.decodeIfPresent(Alert.self, forKey: .alert)
        self.contentAvailable = try container.decodeIfPresent(Int.self, forKey: .contentAvailable)
        self.mutableContent = try container.decodeIfPresent(Int.self, forKey: .mutableContent)
        self.sound = try container.decodeIfPresent(String.self, forKey: .sound)
    }
    
    
    public init(alert: Alert?, contentAvailable: Int?, mutableContent: Int?, sound: String?) {
        self.alert = alert
        self.contentAvailable = contentAvailable
        self.mutableContent = mutableContent
        self.sound = sound
    }
}

public struct Alert: Decodable {
    public let title: String?
    public let body: String?
    
    enum CodingKeys: CodingKey {
        case title
        case body
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
    }
    
    public init(title: String?, body: String?) {
        self.title = title
        self.body = body
    }
}
