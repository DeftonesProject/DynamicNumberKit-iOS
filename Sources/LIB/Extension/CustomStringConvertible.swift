import Foundation

extension CustomStringConvertible {
    func jsonFormatDescription(_ params: (name: String, value: String)...) -> String {
        var json = "\(String(describing: Self.self)) {\n"
        params.forEach { param in
            json = json + "\t\(param.name): \(param.value)\n"
        }
        json = json + "}"
        return json
    }
}
