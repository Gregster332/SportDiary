import Foundation

protocol NetworkManger {
    func getAllExercises(completion: @escaping (Result<[Exercise], Error>) -> Void) async
}
