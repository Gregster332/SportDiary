import Foundation

enum DayOfWeek: String, CaseIterable {
    static var allCases: [DayOfWeek] {
        return [.monday, .tuesday, .wednesday, .tuesday, .friday, .saturday, .sunday]
    }
    
    case monday = "Monday",
         tuesday = "Tuesday",
         wednesday = "Wednesday",
         thusday = "Thusday",
         friday = "Friday",
         saturday = "Saturday",
         sunday = "Sunday"
    case none
    
}
