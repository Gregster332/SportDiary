import Foundation
import RealmSwift

struct ActivityListRow {
    var name: String
    var dayOfWeek: String
    var exercises: List<ExerciseForDB>
}

extension RealmCollection {
    func toArray<T>() -> [T] {
        return self.compactMap { $0 as? T }
    }
}

extension Array where Element == Exercise {
    
    func convertToList() -> List<ExerciseForDB> {
        let newList = List<ExerciseForDB>()
        for elem in self {
            let newElem = ExerciseForDB(elem)
            newList.append(newElem)
        }
        return newList
    }
    
}
