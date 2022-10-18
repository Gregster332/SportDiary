import Foundation
import HealthKit

extension Date  {
    static func mondayAt12Am() -> Self {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class HealthKitAssistantImpl: HealthKitAssistant {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestAuth(completion: @escaping (Bool) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        guard let healthStore = healthStore else {
            return completion(false)
        }
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { success, error in
            completion(success)
        }
    }
    
    func calculateStepsByWeek(timePeriod: TimePeriod, completion: @escaping (Date, HKStatisticsCollection?) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        var startDate: Date?
        var daily: DateComponents?
        
        switch timePeriod {
        case .byWeek:
            
            startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
            daily = DateComponents(day: 1)
        case .byMothsOfYear:
            startDate = Calendar.current.date(byAdding: .month, value: -12, to: Date())
            daily = DateComponents(month: 1)
        case .byYears:
            startDate = Calendar.current.date(byAdding: .year, value: -7, to: Date())
            daily = DateComponents(year: 1)
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        self.query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: startDate!, intervalComponents: daily!)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(startDate!, statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }
    
}

enum TimePeriod {
    case byWeek
    case byMothsOfYear
    case byYears
}
