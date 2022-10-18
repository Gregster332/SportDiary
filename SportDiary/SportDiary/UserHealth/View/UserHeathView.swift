import SwiftUI
import HealthKit
import SwiftUICharts
import Lottie

struct UserHeathView: View {
    
    @StateObject private var userHealthViewModel: UserHealthViewModel = Resolver.shared.resolve(UserHealthViewModel.self)
    
    @State private var favoriteColor = 0
    @State private var open: Bool = false
    
    
    var body: some View {
        NavigationView {
        VStack {
            VStack {
                HStack(alignment: .center) {
                    Button {
                        withAnimation(.interactiveSpring()) {
                            open.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Steps count")
                                .fontWeight(.bold)
                                .font(.title)
                            Image(systemName: open ? "arrow.turn.right.up" : "arrow.turn.right.down")
                                .font(.title2)
                        }
                        .foregroundColor(.black)
                        .padding(.leading, 16)
                    }
                    
                    Spacer()
                    
                    if !open {
                        LottieView(lottieFile: "stepsAnim")
                            .frame(width: 100, height: 100, alignment: .center)
                            .padding(.trailing, 8)
                    }
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10).fill(Color("navBarColor"))
                )
                .padding(.horizontal, 8)
                
                if open {
                    VStack {
                        
                        Picker("What is your favorite color?", selection: $favoriteColor) {
                            Text("By week").tag(0)
                            Text("By months").tag(1)
                            Text("By years").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 16)
                        
                        BarChartView(data: ChartData(values: userHealthViewModel.steps.getOnlySteps()),
                                     title: "Steps",
                                     style: Styles.barChartStyleOrangeLight,
                                     form: CGSize(width: UIScreen.main.bounds.size.width - 64, height: 250),
                                     dropShadow: false,
                                     cornerImage: nil,
                                     valueSpecifier: "%.2f",
                                     animatedToBack: true)
                        .onChange(of: favoriteColor) { newValue in
                            userHealthViewModel.onChange(newValue: newValue)
                        }
                        
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10).fill(Color("lightOrangeColor"))
                            .padding(.horizontal, 8)
                    )
                    
                    .onAppear {
                        userHealthViewModel.onCreate()
                    }
                }
            }
            .background(
                open ? RoundedRectangle(cornerRadius: 10).fill(Color("lightOrangeColor")).padding(.horizontal, 8) : RoundedRectangle(cornerRadius: 10).fill(.clear).padding(.horizontal, 8)
            )
            
            Spacer()
        }
            
        .navigationTitle("Profile")
        .toolbar {
            Button {
                //
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color("navBarColor"))
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
