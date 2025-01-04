import Foundation

extension CreateAccountResponse: CustomStringConvertible {
    public var description: String {
        jsonFormatDescription((name: "id", value: String(id)),
                                     (name: "token", value: token))
    }
}
