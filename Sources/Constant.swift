import Foundation

public enum Constant {
    fileprivate static var bundle: String {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let bundle = dict["CFBundleIdentifier"] as? String {
            return bundle
        } else {
            fatalError("CFBundleIdentifier -> Info.plist")
        }
    }
    
    static var baseURL: String = ""
    static var keychainVersion: String = ""
    
    struct Key {
        static let keychainName = "\(bundle).keychain.key.\(keychainVersion)"
        static let userToken = "\(bundle).keychain.user.token.key.\(keychainVersion)"
        static let userID = "\(bundle).keychain.user.id.key.\(keychainVersion)"
        static let deviceId = "\(bundle).keychain.device.id.key.\(keychainVersion)"
    }
    
    static var deviceId: String {
        if let deviceId = UserDefaults.standard.string(forKey: Key.deviceId) {
            return deviceId
        } else {
            let deviceId = NSUUID().uuidString
            UserDefaults.standard.set(deviceId, forKey: Key.deviceId)
            return deviceId
        }
    }
}
