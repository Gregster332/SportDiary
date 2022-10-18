import SwiftUI
import Lottie

struct StepsView: View {
    
    @State private var open: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            RoundedRectangle(cornerRadius: 10).fill(.gray)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .padding(.horizontal)
            
            RoundedRectangle(cornerRadius: 10).fill(.orange)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.horizontal)
            
            
        }
//        VStack {
//            HStack(alignment: .center) {
//                Button {
//                    open.toggle()
//                } label: {
//                    HStack {
//                        Text("Steps count")
//                            .fontWeight(.bold)
//                            .font(.largeTitle)
//                        Image(systemName: "arrow.turn.right.up")
//                            .font(.title)
//                    }
//                    .foregroundColor(.black)
//                    .padding(.leading, 16)
//                }
//
//                Spacer()
//
//                if !open {
//                LottieView(lottieFile: "stepsAnim")
//                    .frame(width: 100, height: 100, alignment: .center)
//                    .padding(.trailing, 8)
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .background(
//                RoundedRectangle(cornerRadius: 10).fill(.orange)
//            )
//            .padding(.horizontal, 8)
//
//            if open {
//                VStack {
//                    Text("disjid")
//                }
//                .frame(maxWidth: .infinity)
//                .frame(height: 150)
//                .background(.gray)
//            }
//        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        StepsView()
    }
}
