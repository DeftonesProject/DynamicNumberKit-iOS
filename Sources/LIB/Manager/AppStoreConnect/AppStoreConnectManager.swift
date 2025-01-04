import Foundation
import StoreKit

public class AppStoreConnectManager: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    public static let shared = AppStoreConnectManager()
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    private var productsRequest: SKProductsRequest?
    private var products: [SKProduct] = []
    private var completion: ((Result<SKPaymentTransaction, Error>) -> Void)?
    
    public var purchaseLog: ((SKProduct) -> Void)?
    
    public var receipt: String? {
        guard let receiptURL = Bundle.main.appStoreReceiptURL,
              FileManager.default.fileExists(atPath: receiptURL.path) else {
            return nil
        }
        do {
            let receiptData = try Data(contentsOf: receiptURL)
            return receiptData.base64EncodedString(options: [])
        } catch {
            return nil
        }
    }
    
    public func getProduct(with id: String) -> SKProduct? {
        products.first(where: { $0.productIdentifier == id })
    }
    
    public func loadProducts(productIdentifiers: [String]) {
        fetchProducts(productIdentifiers: productIdentifiers)
    }
    
    public func getAllProducts() -> [SKProduct] {
        products
    }
    
    public func purchaseProduct(productIdentifier: String, completionHandler: @escaping (Result<SKPaymentTransaction, Error>) -> Void) {
        guard let product = products.first(where: { $0.productIdentifier == productIdentifier }) else {
            let error = NSError(domain: "PurchaseErrorDomain", code: -2, userInfo: [NSLocalizedDescriptionKey: "Product not found"])
            completionHandler(.failure(error))
            return
        }
        
        if SKPaymentQueue.canMakePayments() {
            completion = completionHandler
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            let error = NSError(domain: "PurchaseErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Payments are disabled on this device"])
            completionHandler(.failure(error))
        }
    }
    
    private func fetchProducts(productIdentifiers: [String]) {
        let productIdentifiersSet = Set(productIdentifiers)
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiersSet)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty {
            products = response.products
        }
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                let skProductID = transaction.payment.productIdentifier
                if let product = products.first(where: { $0.productIdentifier == skProductID }) {
                    purchaseLog?(product)
                }
                completion?(.success(transaction))
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                if let error = transaction.error {
                    completion?(.failure(error))
                } else {
                    let error = NSError(domain: "PurchaseErrorDomain", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred during the purchase"])
                    completion?(.failure(error))
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored, .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
}
