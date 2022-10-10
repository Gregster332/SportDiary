import Foundation

enum AddNewActivityViewState {
    case notStartedAnyTask
    case loading
    case success([Exercise])
    case failure(Error)
}
