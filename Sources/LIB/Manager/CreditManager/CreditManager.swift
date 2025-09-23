import Foundation


public class CreditManager: ObservableObject {
    public static let shared = CreditManager()
    
    @Published public var credit: Credit?

    private func setCreditIfChanged(newCredit: Credit) {
        guard credit?.amount != newCredit.amount || credit?.frozen != newCredit.frozen else {
            return
        }
        credit = newCredit
    }
    
    public func updateCredit(newAmount: Credit) {
        setCreditIfChanged(newCredit: newAmount)
    }

    public func fetchCreditFromServer() {
        _Concurrency.Task {
            do {
                let result = try await DynamicNumberKit.shared.nw.getBalance()
                DispatchQueue.main.async {
                    let newCredit = Credit(amount: result.balance, frozen: result.frozen)
                    self.setCreditIfChanged(newCredit: newCredit)
                }
            }
        }
    }
}
