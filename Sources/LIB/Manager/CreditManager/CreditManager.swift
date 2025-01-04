import Foundation

public class CreditManager {
    public static let shared = CreditManager()
    @Published public var credit: Credit?

    public func updateCredit(newAmount: Int) {
        credit = Credit(amount: newAmount)
    }

    public func fetchCreditFromServer() {
        _Concurrency.Task {
            do {
                let result = try await GetSMS.shared.nw.getBalance()
                DispatchQueue.global().async {
                    let newCredit = Credit(amount: result.balance)
                    DispatchQueue.main.async {
                        self.updateCredit(newAmount: newCredit.amount)
                    }
                }
            }
        }
    }
}



