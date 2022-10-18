import SwiftUI
import FLAnimatedImage

struct ExerciseView: View {

    let exercise: Exercise
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    
    @State private var openForMoreInformation: Bool = false
    @State private var addedInActivityProgram: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(exercise.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text("Target: \(exercise.target)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                
                
                Button {
                    withAnimation(.easeInOut) {
                        openForMoreInformation.toggle()
                    }
                } label: {
                    HStack {
                        Text(openForMoreInformation ? "Close" : "More information")
                        Image(systemName: openForMoreInformation ? "arrow.turn.right.up" : "arrow.turn.right.down")
                    }
                    .foregroundColor(Color("navBarColor"))
                }
                .padding(.trailing, 8)
            }
            
            if openForMoreInformation {
                VStack(alignment: .center) {
                    VStack(alignment: .center) {
                        Text("Body part: \(exercise.bodyPart)")
                            .fontWeight(.medium)
                        Text("Equipment: \(exercise.equipment)")
                            .fontWeight(.medium)
                    }
                    .font(.body)
                    
                    if let url = URL(string: exercise.gifUrl) {
                        GIFView(type: .url(url))
                            .frame(width: 200, height: 200, alignment: .center)
                    } else {
                        Text("No gif")
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            }
            
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(exercise.containedIn(addNewActivityViewModel.finalActivityProgram) ?
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.green, lineWidth: 1) :
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal, 8)
        .onTapGesture {
            withAnimation(.easeInOut) {
                if !addNewActivityViewModel.finalActivityProgram.contains(where: { exercise in
                    self.exercise.id == exercise.id
                }) {
                    addedInActivityProgram = true
                    addNewActivityViewModel.finalActivityProgram.append(self.exercise)
                }
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    
    static let addNewActivityViewModel = AddNewActivityViewModel()
    
    static var previews: some View {
        ExerciseView(exercise: Exercise(
            bodyPart:"waist",
            equipment:"body weight",
            gifUrl:"http://d205bpvrqc9yn1.cloudfront.net/0001.gif",
            id:"0001",
            name:"3/4 sit-up",
            target:"abs"
        ))
        .preferredColorScheme(.dark)
        .environmentObject(addNewActivityViewModel)
    }
}
