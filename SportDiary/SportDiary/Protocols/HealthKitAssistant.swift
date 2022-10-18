import Foundation
import HealthKit

protocol HealthKitAssistant {
    func requestAuth(completion: @escaping (Bool) -> Void)
    func calculateStepsByWeek(timePeriod: TimePeriod, completion: @escaping (Date, HKStatisticsCollection?) -> Void)
//    func calculateStepsByMonths(completion: @escaping (Date, HKStatisticsCollection?) -> Void)
//    func calculateStepsByLastSevenYears(completion: @escaping (Date, HKStatisticsCollection?) -> Void)
}
