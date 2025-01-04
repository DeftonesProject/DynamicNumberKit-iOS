import Foundation

protocol APIProtocol {
    func createAccount() async throws -> CreateAccountResponse
    func getServiceCategory() async throws -> ServiceCategoryResponse
    func getServicesList() async throws -> [ServiceModel]
    func getCountriesForServices(services: String) async throws -> [CountryModel]
    func getBalance() async throws -> GetBalanceResponse
    func buyNumber(serviceID: String, countryID: Int) async throws -> BuyNumberResponse
    func getActivationList() async throws -> ActivationResponse
    func getActivationStatus(serviceID: String) async throws -> ActivationStatusResponse
    func topUpBalance(price: String, currency: String) async throws -> EmptyResponse
    func registerPush(pushToken: String) async throws -> EmptyResponse
    func restorePurchase() async throws -> CreateAccountResponse
    func deleteAccount() async throws -> EmptyResponse
    func returnNumber(internalID: Int) async throws -> AccessStatusResponse
}
