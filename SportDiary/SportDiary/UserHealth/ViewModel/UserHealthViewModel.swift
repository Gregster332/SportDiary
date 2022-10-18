import Foundation
import HealthKit

class UserHealthViewModel: ObservableObject {
    
    @Published var steps: [Step] = []
    
    var heakthKitAssistant: HealthKitAssistant
    
    init(heakthKitAssistant: HealthKitAssistant) {
        self.heakthKitAssistant = heakthKitAssistant
    }
    
    func updateWithStatistics(startDate: Date, statisticsCollection: HKStatisticsCollection) {
        statisticsCollection.enumerateStatistics(from: startDate, to: Date()) { [weak self] statistics, stopPoint in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: count ?? 0, date: statistics.startDate)
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.steps.append(step)
            }
        }
    }
    
    func onChange(newValue: Int) {
        steps.removeAll()
        heakthKitAssistant.calculateStepsByWeek(timePeriod: newValue == 0 ? .byWeek : newValue == 1 ? .byMothsOfYear : .byYears) { [weak self] date, collection in
            if let self = self, let collection = collection {
                self.updateWithStatistics(startDate: date, statisticsCollection: collection)
            }
        }
    }
    
    func onCreate() {
        steps.removeAll()
        heakthKitAssistant.requestAuth(completion: { [weak self] success in
            if let self = self, success {
                self.heakthKitAssistant.calculateStepsByWeek(timePeriod: .byWeek) { date, collection in
                    if let collection = collection {
                        self.updateWithStatistics(startDate: date, statisticsCollection: collection)
                    }
                }
            }
        })
    }
    
}
