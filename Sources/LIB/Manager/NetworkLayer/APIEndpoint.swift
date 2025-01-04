import Foundation
import Alamofire

public enum APIEndpoint: TargetType {
    case createAccount
    case getServiceCategory
    case restoreAccount
    case getServicesList
    case getCountriesForService(serviceID: String)
    case getBalance
    case buyNumber(serviceID: String, countryID: Int)
    case getActivationList
    case getActivationStatus(serviceID: String)
    case topUpBalance(amount: String, currency: String)
    case registerPush(pushToken: String)
    case deleteAccount
    case returnNumber(internalID: Int)

    public var baseURL: String {
        return Constant.baseURL
    }
    
    public var path: String {
        switch self {
        case .createAccount: return "/v1/account"
        case .getServiceCategory: return "/v1/activations/service_categories"
        case .restoreAccount: return "/v1/account/subscriptions/restore"
        case .getServicesList: return "/v1/activations/services"
        case .getCountriesForService(let serviceID): return "/v1/activations/services/\(serviceID)/countries"
        case .getBalance: return "/v1/account/balance"
        case .buyNumber: return "/v1/activations/buy_number"
        case .getActivationList: return "/v1/activations/list"
        case .getActivationStatus(let serviceID): return "/v1/activations/\(serviceID)/status"
        case .topUpBalance: return "/v1/account/in_app_purchases"
        case .registerPush: return "/v1/account/devices"
        case .deleteAccount: return "/v1/account"
        case .returnNumber(let internalID): return "/v1/activations/\(internalID)/status"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .createAccount, .restoreAccount, .buyNumber, .topUpBalance, .registerPush: return .post
        case .getServicesList, .getServiceCategory, .getCountriesForService, .getBalance, .getActivationList, .getActivationStatus: return .get
        case .deleteAccount: return .delete
        case .returnNumber: return .post
        }
    }
    
    public var task: Task {
        var params: [String: Any] = [:]
        
        switch self {
        case .createAccount,
                .getServiceCategory,
                .getServicesList,
                .getBalance,
                .getActivationList,
                .getActivationStatus,
                .deleteAccount,
                .getCountriesForService:
            return .requestPlain
        case .restoreAccount:
            params["bundle"] = Bundle.main.bundleIdentifier!
            params["receipt"] = AppStoreConnectManager.shared.receipt ?? ""
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .buyNumber(serviceID: let serviceID, countryID: let countryID):
            params["service_id"] =  serviceID
            params["country_id"] =  countryID
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .topUpBalance(amount: let price, currency: let currency):
            params["bundle"] = Bundle.main.bundleIdentifier!
            params["receipt"] = AppStoreConnectManager.shared.receipt ?? ""
            params["price"] = price
            params["currency"] = currency
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .registerPush(let tokenId):
            params["device_id"] = Constant.deviceId
            params["push_token"] = tokenId
            params["bundle"] = Bundle.main.bundleIdentifier!
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .returnNumber(internalID: let internalID):
            params["id"] = internalID
            params["status"] = 8
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    public  var headers: [String: String]? {
        var params: [String: String] = ["Content-Type": "application/json"]

        switch self {
        case .createAccount,
                .getServiceCategory,
                .getCountriesForService,
                .restoreAccount,
                .getServicesList:
            break
        case .getBalance,
                .buyNumber,
                .getActivationList,
                .getActivationStatus,
                .topUpBalance,
                .registerPush,
                .deleteAccount,
                .returnNumber:
            if let userToken = UserDataManager.userToken {
                params["Authorization"] = "OAuth \(userToken)"
            }
        }
        return params
    }
}


