import Foundation

class AddNewActivityViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isLoadingNeeded: Bool = true
    @Published var showListIsEmptyAlert: Bool = false
    @Published var isError: Error? = nil
    @Published var fetchedExercises: [Exercise] = []
    @Published var selectedDay: DayOfWeek = .none
    @Published var finalActivityProgram: [Exercise] = []
    
    @Inject private var networkManager: NetworkManger
    @Inject private var realmManager: RealMManager
    
    func getListOfAllExercises() async throws {
        isLoading = true
        await networkManager.getAllExercises { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let exercises):
                DispatchQueue.main.async {
                    self.fetchedExercises = exercises
                    self.isLoadingNeeded = false
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isError = error
                    self.isLoading = false
                }
            }
        }
    }
    
    func saveNewProgram(program: ExerciseProgram) {
        realmManager.saveActivityProgram(program)
    }
}
