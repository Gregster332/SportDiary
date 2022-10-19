import SwiftUI
import HealthKit
import SwiftUICharts

struct StepsView: View {
    
    @EnvironmentObject var userHealthViewModel: UserHealthViewModel
    
    var body: some View {
            VStack {
                HStack(alignment: .center) {
                    Button {
                        withAnimation(.interactiveSpring()) {
                            userHealthViewModel.openInfo.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Steps count")
                                .fontWeight(.bold)
                                .font(.title)
                            Image(systemName: userHealthViewModel.openInfo ? "arrow.turn.right.up" : "arrow.turn.right.down")
                                .font(.title2)
                        }
                        .foregroundColor(.black)
                        .padding(.leading, 16)
                    }
                    
                    Spacer()
                    
                    if !userHealthViewModel.openInfo {
                        LottieView(lottieFile: "stepsAnim")
                            .frame(width: 100, height: 100, alignment: .center)
                            .padding(.trailing, 8)
                    }
                }

                if userHealthViewModel.openInfo {
                    VStack {
                        
                        Picker("What is your favorite color?", selection: $userHealthViewModel.favoriteColor) {
                            Text("By week").tag(0)
                            Text("By months").tag(1)
                            Text("By years").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 16)
                        
                        BarChartView(data: ChartData(values: userHealthViewModel.steps.getOnlySteps()),
                                     title: "Steps",
                                     style: Styles.barChartStyleOrangeLight,
                                     form: CGSize(width: UIScreen.main.bounds.size.width - 48, height: 250),
                                     dropShadow: false,
                                     cornerImage: nil,
                                     valueSpecifier: "%.0f",
                                     animatedToBack: true)
                        .onChange(of: userHealthViewModel.favoriteColor) { newValue in
                            userHealthViewModel.onChange(newValue: newValue)
                        }
                        
                    }
                    .onAppear {
                        userHealthViewModel.onCreate()
                    }
                    .onDisappear {
                        userHealthViewModel.onClose()
                    }
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("navBarColor"))
                    .padding(. horizontal, 8)
            )
    }
}

struct UserHeathView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView()
    }
}
