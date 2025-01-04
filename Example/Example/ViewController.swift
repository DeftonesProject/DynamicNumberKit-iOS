import UIKit
import GETSms
import Combine

class ViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getServices()
        getProducts()
        bindToCreditUpdates()
        getServiceCategory()
    }
    
    private func getServiceCategory() {
        _Concurrency.Task {
            let result = try await GetSMS.shared.nw.getServiceCategory()
            result.categories.forEach({print($0.title)})
        }
    }
    
    private func getProducts() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            let products = GetSMS.shared.appStoreManager.getAllProducts()
            products.forEach({print($0.price.stringValue)})
        })
    }
    
    private func getServices() {
        _Concurrency.Task {
            let result = try await GetSMS.shared.nw.getServicesList()
            print(result)
        }
    }
    
    private func bindToCreditUpdates() {
        CreditManager.shared.$credit
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] credit in
                print(credit)
            }
            .store(in: &cancellables)
    }
}

