import Foundation
import RealmSwift

class MainScreenViewModel: ObservableObject {
    
    var networkManager: NetworkManger
    var realmManager: RealMManager
    
    init(networkManager: NetworkManger, realmManager: RealMManager) {
        self.networkManager = networkManager
        self.realmManager = realmManager
    }
    
    func fetchExercisesAndCache() async {
        if !checkDBContainsObjectOfType() {
            await networkManager.getAllExercises { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let exercises):
                    DispatchQueue.main.async {
                        self.realmManager.saveExercises(exercises: exercises)
                    }
                case .failure(let error): print(error.localizedDescription)
                }
                // на экране выбора упражнений не подгружать их из сети, а доставать из бд
            }
        } else {
            return
        }
    }
    
    private func checkDBContainsObjectOfType() -> Bool {
        return (realmManager as! RealMManagerImpl).checkDBAlreadyContainsObjectsOf(ExerciseForDB.self)
    }
    
}
