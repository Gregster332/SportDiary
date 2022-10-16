import Foundation
import HealthKit

protocol HealthKitAssistant {
    func requestAuth(completion: @escaping (Bool) -> Void)
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void)
}
