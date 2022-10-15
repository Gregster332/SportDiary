import Foundation
import RealmSwift

class ActivityListViewModel: ObservableObject {
    
    let dayOfWeeks: DayOfWeek = .monday
    @Published var openAddNewActivityView: Bool = false
    @Published var exercisesPrograms: [ExerciseProgram] = []
    
    @Inject private var realmManager: RealMManager
    
    func getAllExercisesPrograms() {
        exercisesPrograms = Array(realmManager.getAllExercises())
        print(exercisesPrograms)
    }
    
}
