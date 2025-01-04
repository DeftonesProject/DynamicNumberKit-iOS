import Foundation

public struct ActivationStatusResponse: Decodable {
    public var status: Status
    
    public enum Status: String, Decodable {
        case invalidPhone = "INVALID_PHONE"
        case statusFinish = "STATUS_FINISH"
        case statusCancel = "STATUS_CANCEL"
        case statusWaitCode = "STATUS_WAIT_CODE"
        case statusRevoke = "STATUS_REVOKE"
        case unknown = "UNKNOWN"
    }
    
    enum CodingKeys: String, CodingKey {
        case status
    }
}
