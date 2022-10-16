import Foundation

extension Exercise {
    func containedIn(_ array: Array<Self>) -> Bool {
        var isContained = false
        for exercise in array {
            if self.id == exercise.id {
                isContained = true
            }
        }
        return isContained
    }
}
