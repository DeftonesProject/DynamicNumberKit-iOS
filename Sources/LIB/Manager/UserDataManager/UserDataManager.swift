import Foundation
import KeychainAccess

public class UserDataManager {
    
    public static var isUserAuthorized: Bool {
        return userToken != nil
    }
    
    static public var userToken: String? {
        get {
            let keychain = Keychain(service: Constant.Key.keychainName)
            return keychain[Constant.Key.userToken]
        }
        set {
            let keychain = Keychain(service: Constant.Key.keychainName)
            if let newValue = newValue {
                try! keychain.synchronizable(true).set(newValue, key: Constant.Key.userToken)
            } else {
                try! keychain.synchronizable(true).remove(Constant.Key.userToken)
            }
        }
    }
    
    public static var userID: Int? {
        get {
            let keychain = Keychain(service: Constant.Key.keychainName)
            if let userIDString = keychain[Constant.Key.userID] {
                return Int(userIDString)
            }
            return nil
        }
        set {
            let keychain = Keychain(service: Constant.Key.keychainName)
            if let newValue = newValue {
                let userIDString = String(newValue)
                try! keychain.synchronizable(true).set(userIDString, key: Constant.Key.userID)
            } else {
                try! keychain.synchronizable(true).remove(Constant.Key.userID)
            }
        }
    }
    
    public static func deleteAccountData() {
        UserDataManager.userID = nil
        UserDataManager.userToken = nil
        CreditManager.shared.updateCredit(newAmount:Credit( amount: 0, frozen: 0))
    }
}




