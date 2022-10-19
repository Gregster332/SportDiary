import Foundation
import RealmSwift

protocol RealMManager {
    func saveActivityProgram(_ program: ExerciseProgram)
    func getAllExercisesPrograms() -> [ExerciseProgram]
    func deleteObject(exerciseProgram: ExerciseProgram)
    func getAllExercises() -> [ExerciseForDB]
    func saveExercises(exercises: [Exercise])
    func getObjectsByExercisesIds(ids: [String]) -> [ExerciseForDB]
}
