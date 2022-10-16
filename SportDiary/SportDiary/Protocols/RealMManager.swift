import Foundation
import RealmSwift

protocol RealMManager {
    func saveActivityProgram(_ program: ExerciseProgram)
    func getAllExercises() -> [ExerciseProgram]
    func deleteObject(exerciseProgram: ExerciseProgram)
}
