import Foundation
import RealmSwift

extension Array where Element == String {
    
    func convertToList() -> RealmSwift.List<String> {
        let newList = RealmSwift.List<String>()
        for elem in self {
            //let newElem = ExerciseForDB(elem)
            newList.append(elem)
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
