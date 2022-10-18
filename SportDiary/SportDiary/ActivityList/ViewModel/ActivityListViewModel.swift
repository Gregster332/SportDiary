import Foundation
import RealmSwift

class ActivityListViewModel: ObservableObject {
    
    let dayOfWeeks: DayOfWeek = .monday
    
    private var realmManager: RealMManager
    
    @Published var exercisesPrograms: [ExerciseProgram] = []
    @Published var addNewActivityProgramIsOpen: Bool = false
    
    init(realmManager: RealMManager) {
        self.realmManager = realmManager
    }
    
    func getAllExercisesPrograms() {
        exercisesPrograms = Array(realmManager.getAllExercises())
    }
    
    func deleteExerciseProgram(program: ExerciseProgram, index: Int) {
        realmManager.deleteObject(exerciseProgram: program)
        getAllExercisesPrograms()
    }
    
}
