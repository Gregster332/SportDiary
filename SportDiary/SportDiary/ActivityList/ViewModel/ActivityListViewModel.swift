import Foundation
import RealmSwift

class ActivityListViewModel: ObservableObject {
    
    let dayOfWeeks: DayOfWeek = .monday
    
    @Published var exercisesPrograms: [ExerciseProgram] = []
    @Published var addNewActivityProgramIsOpen: Bool = false
    
    @Inject private var realmManager: RealMManager
    
    func getAllExercisesPrograms() {
        exercisesPrograms = Array(realmManager.getAllExercises())
    }
    
    func deleteExerciseProgram(program: ExerciseProgram) {
        print("=============delete===============")
        realmManager.deleteObject(exerciseProgram: program)
    }
    
}
