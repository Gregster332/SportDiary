import Foundation
import RealmSwift

protocol RealMManager {
    func saveActivityProgram(_ program: ExerciseProgram)
    func getAllExercises() -> Results<ExerciseProgram>
    func deleteObject(exerciseProgram: ExerciseProgram)
}
