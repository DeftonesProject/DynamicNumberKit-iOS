import Foundation
import Alamofire

public class BaseAPI<T: TargetType> {
    
    weak var errorHandler: NetworkErrorHandler?
    
    public init(errorHandler: NetworkErrorHandler? = nil) {
        self.errorHandler = errorHandler
    }
    
    func fetchData<M: Decodable>(
        target: T,
        responseClass: M.Type
    ) async throws -> M {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)

        do {
             let response = AF.request(
                target.baseURL + target.path,
                method: method,
                parameters: parameters.0,
                encoding: parameters.1,
                headers: headers
             ).response { response in
             }
            return try await response.serializingDecodable(M.self).value
        } catch let error as AFError {
            if error.isSessionTaskError || (error.underlyingError as NSError?)?.code == NSURLErrorTimedOut {
                let requestDetails = RequestDetails(target: target, responseClass: responseClass)
                throw NetworkError.timeout(requestDetails)
            } else {
                throw NetworkError.other(error)
            }
        } catch {
            throw NetworkError.other(error)
        }
    }
    
    private func buildParams(task: Task) -> ([String: Any]?, ParameterEncoding) {
        switch task {
        case .requestPlain:
            let encoding = URLEncoding(destination: .methodDependent, arrayEncoding: .noBrackets, boolEncoding: .literal)
            return (nil, encoding)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
