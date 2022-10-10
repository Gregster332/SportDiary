import Foundation

class ActivityListViewModel: ObservableObject {
    
    let dayOfWeeks: [String] = ["Monday", "Tuesday", "Wednesday", "Thusday", "Friday", "Saturday", "Sunday"]
    @Published var openAddNewActivityView: Bool = false
    
}
