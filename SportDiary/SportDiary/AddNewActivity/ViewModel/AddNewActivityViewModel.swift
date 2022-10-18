import Foundation

class AddNewActivityViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isLoadingNeeded: Bool = true
    @Published var showListIsEmptyAlert: Bool = false
    @Published var isError: Error? = nil
    @Published var selectedTab: Int = 0
    @Published var nameOfProgram: String = ""
    @Published var searchedText: String = ""
    @Published var fetchedExercises: [Exercise] = []
    @Published var selectedDay: DayOfWeek = .none
    @Published var finalActivityProgram: [Exercise] = []
    
    private var networkManager: NetworkManger
    private var realmManager: RealMManager
    
    var serchedResults: [Exercise] {
        if searchedText.isEmpty {
            return fetchedExercises
        } else {
            return fetchedExercises
                .filter({$0.name.contains(searchedText)})
        }
    }
    
    init(networkManager: NetworkManger, realmManager: RealMManager) {
        self.networkManager = networkManager
        self.realmManager = realmManager
    }
    
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
    
    func nextButtonTapped() {
        if !finalActivityProgram.isEmpty {
                selectedTab += 1
        } else {
            showListIsEmptyAlert = true
        }
    }
}
