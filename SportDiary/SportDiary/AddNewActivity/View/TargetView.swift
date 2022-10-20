import SwiftUI

struct TargetView: View {
    
    let target: String
    @State private var isOpen: Bool = false
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                isOpen.toggle()
            }, label: {
                HStack {
                    Text("Target: \(target)")
                    Spacer()
                }
                .foregroundColor(.black)
            })
            .sheet(isPresented: $isOpen) {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(addNewActivityViewModel.getExercisesByTarget(target: target), id: \.self) { exercise in
                        ExerciseView(exercise: exercise)
                    }
                }
                .padding(.vertical, 16)
            }
            
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("navBarColor"))
        )
        .padding(.horizontal, 8)
        
        .environmentObject(addNewActivityViewModel)
    }
}
