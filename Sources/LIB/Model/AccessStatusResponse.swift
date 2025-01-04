import Foundation

public struct AccessStatusResponse: Decodable {
    let status: AccessStatus
}

public enum AccessStatus: String, Decodable {
    case accessReady = "ACCESS_READY"
    case accessRetryGet = "ACCESS_RETRY_GET"
    case accessActivation = "ACCESS_ACTIVATION"
    case accessCancel = "ACCESS_CANCEL"
}
