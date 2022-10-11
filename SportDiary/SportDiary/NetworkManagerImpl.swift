import Foundation
import UIKit

protocol NetworkManger {
    func getAllExercises(completion: @escaping (Result<[Exercise], Error>) -> Void) async
}

class NetworkManagerImpl: ObservableObject, NetworkManger {
    
//    @Published var exercises: [Exercise] = []
//    @Published var loading: Bool = false
    
    private let headers = [
        "X-RapidAPI-Key": "b2963da0fdmsh66c20dfbd80b4ebp1a219fjsncf6fd681345e",
        "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
    ]
    
//    func get() {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            self.getAllExercises { result in
//                switch result {
//                case .success(let exercises):
//                    print("ok")
////                    self.exercises = exercises
////                    self.loading = false
//                case .failure(let error): print(error.localizedDescription)
//                }
//            }
//        }
//    }
    
     func getAllExercises(completion: @escaping (Result<[Exercise], Error>) -> Void) async {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://exercisedb.p.rapidapi.com/exercises")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        //loading = true
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
