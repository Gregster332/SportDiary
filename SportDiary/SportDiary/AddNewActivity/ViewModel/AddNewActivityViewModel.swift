import Foundation


class AddNewActivityViewModel: ObservableObject {
    
    @Published var addNewActivityViewState: AddNewActivityViewState = .notStartedAnyTask
    @Published var selectedDay: String = ""
    
    var networkManager: SportApi
    
    init(networkManager: SportApi = SportApi()) {
        self.networkManager = networkManager
    }
    
    func getListOfAllExercises() async throws {
        addNewActivityViewState = .loading
        await networkManager.getAllExercises { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let exercises):
                DispatchQueue.main.async {
                    self.addNewActivityViewState = .success(exercises)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.addNewActivityViewState = .failure(error)
                }
            }
        }
    }
    
}
