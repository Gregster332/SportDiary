import Foundation
import UIKit

class NetworkManagerImpl: ObservableObject, NetworkManger {
    
    let headers = [
        "X-RapidAPI-Key": "bcb05a9379mshb92cc3b7a7761d0p1c6576jsn682703f0c7d0",
        "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
    ]
    
     func getAllExercises(completion: @escaping (Result<[Exercise], Error>) -> Void) async {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://exercisedb.p.rapidapi.com/exercises")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data = data else {
                    return
                }
                do {
                    let object = try JSONDecoder().decode([Exercise].self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
        })
        
        dataTask.resume()
    }
}
