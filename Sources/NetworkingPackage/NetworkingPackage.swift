// NetworkingPackage for Swift
//
// Akaki da igi

import Foundation

public enum NetworkError: Error {
    case badRequest
    case decodingError
}

public class NetworkManager {
    public init() {}
    
    public func fetchData<T: Codable>(url: URL, parse: @escaping (Data) -> T?, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(.failure(NetworkError.decodingError))
                return
            }
            let result  = parse(data)
            completion(.success(result))
        }.resume()
    }
}
