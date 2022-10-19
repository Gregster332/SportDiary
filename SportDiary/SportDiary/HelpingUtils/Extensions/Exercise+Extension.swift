import Foundation

extension String {
    func containedIn(_ array: Array<Self>) -> Bool {
        var isContained = false
        for id in array {
            if self == id {
                isContained = true
            }
        }
        return isContained
    }
}
