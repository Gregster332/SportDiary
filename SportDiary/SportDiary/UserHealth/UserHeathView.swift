import SwiftUI
import HealthKit

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

struct UserHeathView: View {
    
    @Inject var heakthKitAssistant: HealthKitAssistant
    @State private var steps: [Step] = []
    
    private func updateWithStatistics(statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        statisticsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, stopPoint in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
    
    var body: some View {
        List(steps, id: \.id) { step in
            VStack {
                Text("\(step.count)")
                Text("\(step.date)")
            }
        }
        .onAppear {
            heakthKitAssistant.requestAuth { success in
                if success {
                    heakthKitAssistant.calculateSteps { collection in
                        if let collection = collection {
                            if steps.isEmpty {
                            updateWithStatistics(statisticsCollection: collection)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct UserHeathView_Previews: PreviewProvider {
    static var previews: some View {
        UserHeathView()
    }
}
