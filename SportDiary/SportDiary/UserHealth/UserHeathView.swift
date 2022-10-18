import SwiftUI
import HealthKit
import SwiftUICharts

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

struct UserHeathView: View {
    
    @Inject var heakthKitAssistant: HealthKitAssistant
    @State private var steps: [Step] = []
    @State private var favoriteColor = 0
    
    private func updateWithStatistics(startDate: Date, statisticsCollection: HKStatisticsCollection) {
        statisticsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, stopPoint in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
    
    var body: some View {
        VStack {
            
            Picker("What is your favorite color?", selection: $favoriteColor) {
                Text("By week").tag(0)
                Text("By months").tag(1)
                Text("By years").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
            
            BarChartView(data: ChartData(values: steps.getOnlySteps()),
                         title: "Some title",
                         style: Styles.barChartStyleOrangeLight,
                         form: CGSize(width: UIScreen.main.bounds.size.width - 32, height: 250),
                         dropShadow: true,
                         cornerImage: Image(systemName: "plus"),
                         valueSpecifier: "%.2f",
                         animatedToBack: true)
            .onChange(of: favoriteColor) { newValue in
                steps.removeAll()
                heakthKitAssistant.calculateStepsByWeek(timePeriod: newValue == 0 ? .byWeek : newValue == 1 ? .byMothsOfYear : .byYears) { date, collection in
                    if let collection = collection {
                        updateWithStatistics(startDate: date, statisticsCollection: collection)
                    }
                }
            }
            
        }
        .onAppear {
            heakthKitAssistant.requestAuth(completion: { success in
                if success {
                    heakthKitAssistant.calculateStepsByWeek(timePeriod: .byWeek) { date, collection in
                        if let collection = collection {
                            updateWithStatistics(startDate: date, statisticsCollection: collection)
                        }
                    }
                }
            })
        }
    }
}

struct UserHeathView_Previews: PreviewProvider {
    static var previews: some View {
        UserHeathView()
    }
}


extension Array where Element == Step {
    
    func getOnlySteps() -> [(String, Double)] {
        let newArray: [(String, Double)] = self.compactMap { step in
            if step.count != 0 {
                return (step.date.toString(), Double(step.count))
            } else {
                return nil
            }
        }
        return newArray
    }
}

extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
