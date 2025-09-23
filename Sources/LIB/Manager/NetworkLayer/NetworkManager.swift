import Foundation
import Alamofire

public class NetworkManager: BaseAPI<APIEndpoint>, APIProtocol {

    private init() {}

    public static let shared = NetworkManager()
    fileprivate let api = BaseAPI<APIEndpoint>()
    
    public func createAccount() async throws -> CreateAccountResponse {
        let result = try await api.fetchData(target: APIEndpoint.createAccount, responseClass: CreateAccountResponse.self)
        UserDataManager.userID = result.id
        UserDataManager.userToken = result.token
        return result
    }
    
    public func getServicesList() async throws -> [ServiceModel] {
        try await api.fetchData(target: APIEndpoint.getServicesList, responseClass: [ServiceModel].self)
    }
    
    public func getServiceCategory() async throws -> ServiceCategoryResponse {
        try await api.fetchData(target: .getServiceCategory, responseClass: ServiceCategoryResponse.self)
    }
    
    public func getCountriesForServices(services service: String) async throws -> [CountryModel] {
        try await api.fetchData(target: APIEndpoint.getCountriesForService(serviceID: service), responseClass: [CountryModel].self)
    }

    public func getBalance() async throws -> GetBalanceResponse {
        try await api.fetchData(target: APIEndpoint.getBalance, responseClass: GetBalanceResponse.self)
    }
    
    public func buyNumber(serviceID: String, countryID: Int) async throws -> BuyNumberResponse {
        try await api.fetchData(target: APIEndpoint.buyNumber(serviceID: serviceID, countryID: countryID), responseClass: BuyNumberResponse.self)
    }
    
    public func topUpBalance(price: String, currency: String) async throws -> EmptyResponse {
        try await api.fetchData(target: APIEndpoint.topUpBalance(amount: price, currency: currency), responseClass: EmptyResponse.self)
    }
    
    public func getActivationList() async throws -> ActivationResponse {
        try await api.fetchData(target: APIEndpoint.getActivationList, responseClass: ActivationResponse.self)
    }
    
    public func getActivationStatus(serviceID: String) async throws -> ActivationStatusResponse {
        try await api.fetchData(target: APIEndpoint.getActivationStatus(serviceID: serviceID), responseClass: ActivationStatusResponse.self)
    }
    
    public func registerPush(pushToken: String) async throws -> EmptyResponse {
        try await api.fetchData(target: APIEndpoint.registerPush(pushToken: pushToken), responseClass: EmptyResponse.self)
    }
    
    public func restorePurchase() async throws -> CreateAccountResponse {
        let result = try await api.fetchData(target: APIEndpoint.restoreAccount, responseClass: CreateAccountResponse.self)
        UserDataManager.userID = result.id
        UserDataManager.userToken = result.token
        return result
    }
    
    public func deleteAccount() async throws -> EmptyResponse {
        try await api.fetchData(target: APIEndpoint.deleteAccount, responseClass: EmptyResponse.self)
    }
    
    public func returnNumber(internalID: Int) async throws -> EmptyResponse {
        try await api.fetchData(target: APIEndpoint.returnNumber(internalID: internalID), responseClass: EmptyResponse.self)
    }
}
