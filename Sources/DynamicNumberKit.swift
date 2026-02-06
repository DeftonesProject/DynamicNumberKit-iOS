import Foundation
import StoreKit
import UserAcquisition

public class DynamicNumberKit {
    public static let shared = DynamicNumberKit()
    public let nw = NetworkManager.shared
    public let appStoreManager = AppStoreConnectManager.shared
    
    public func configure(model: ConfigurationApp) {
        Constant.baseURL = model.baseURL
        Constant.keychainVersion = model.keychainVersion
        AppStoreConnectManager.shared.loadProducts(productIdentifiers: model.productIdentifiers)
        AppStoreConnectManager.shared.purchaseLog = { product in
            UserAcquisition.shared.logPurchase(of: product)
        }
        if UserDataManager.isUserAuthorized {
            CreditManager.shared.fetchCreditFromServer()
        }
    }
    
    public func sendPurchaseLog(buy product: SKProduct) -> Void {
        UserAcquisition.shared.logPurchase(of: product)
    }

    private func configureUserAcquisition(model: UserAcquisitionModel) {
        UserAcquisition.shared.configure(withAPIKey: model.userAcquisitionAPIKey)
        UserAcquisition.shared.conversionInfo.amplitudeId = model.amplitudeID
        UserAcquisition.shared.conversionInfo.appmetricaId = model.appMetricaID
    }
}

public struct ConfigurationApp {
    var keychainVersion: String
    var baseURL: String
    var productIdentifiers: [String]
    var userAcquisitionModel: UserAcquisitionModel

    public init(
        keychainVersion: String,
        baseURL: String,
        productIdentifiers: [String],
        userAcquisitionModel: UserAcquisitionModel
    ) {
        self.baseURL = baseURL
        self.productIdentifiers = productIdentifiers
        self.userAcquisitionModel = userAcquisitionModel
        self.keychainVersion = keychainVersion
    }
}

public struct UserAcquisitionModel {
    public var userAcquisitionAPIKey: String
    public var amplitudeID: String
    public var appMetricaID: String
    
    public init(userAcquisitionAPIKey: String, amplitudeID: String, appMetricaID: String) {
        self.userAcquisitionAPIKey = userAcquisitionAPIKey
        self.amplitudeID = amplitudeID
        self.appMetricaID = appMetricaID
    }
}
