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
