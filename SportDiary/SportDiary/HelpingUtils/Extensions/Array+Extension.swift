import Foundation
import RealmSwift

extension Array where Element == Exercise {
    
    func convertToList() -> RealmSwift.List<ExerciseForDB> {
        let newList = RealmSwift.List<ExerciseForDB>()
        for elem in self {
            let newElem = ExerciseForDB(elem)
            newList.append(newElem)
        }
        return newList
    }
}

extension Array where Element == Step {
    
    func getOnlySteps() -> [(String, Double)] {
        let newArray: [(String, Double)] = self.compactMap { step in
            if step.count != 0 {
                return (step.date.toString(), step.count)
            } else {
                return nil
            }
        }
        return newArray
    }
}
