import Foundation

class AddNewActivityViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showListIsEmptyAlert: Bool = false
    @Published var selectedTab: Int = 0
    @Published var nameOfProgram: String = ""
    @Published var searchedText: String = ""
    @Published var fetchedExercises: [Exercise] = []
    @Published var selectedDay: DayOfWeek = .none
    @Published var finalActivityProgramIds: [String] = []
    
    let targets = [
        "abductors",
        "abs",
        "adductors",
        "biceps",
        "calves",
        "cardiovascular system",
        "delts",
        "forearms",
        "glutes",
        "hamstrings",
        "lats",
        "levator scapulae",
        "pectorals",
        "quads",
        "serratus anterior",
        "spine",
        "traps",
        "triceps",
        "upper back"
    ]
    
    private var networkManager: NetworkManger
    private var realmManager: RealMManager
    
    var serchedResults: [Exercise] {
        if searchedText.isEmpty {
            return []
        } else {
            return fetchedExercises
                .filter({$0.name.contains(searchedText)})
        }
    }
    
    init(networkManager: NetworkManger, realmManager: RealMManager) {
        self.networkManager = networkManager
        self.realmManager = realmManager
    }
    
    func getExerciseByExerciseId(id: String) -> Exercise {
        return realmManager.getObjecyByExerciseId(id: id).cast()
    }
    
    func getAllExercises() {
        isLoading = true
        if fetchedExercises.isEmpty {
            fetchedExercises = realmManager.getAllExercises().map({ exerciseeForDB in
                return exerciseeForDB.cast()
            })
        }
        isLoading = false
    }
    
    func saveNewProgram(program: ExerciseProgram) {
        realmManager.saveActivityProgram(program)
        selectedTab = 0
    }
    
    func nextButtonTapped() {
        if !finalActivityProgramIds.isEmpty {
                selectedTab += 1
        } else {
            showListIsEmptyAlert = true
        }
    }
    
    func getExercisesByTarget(target: String) -> [Exercise] {
        return realmManager.getExercisesByTarget(target: target).map { exercisesForDB in
            return exercisesForDB.cast()
        }
    }
}
