import SwiftUI
import RealmSwift

struct ConfirmActivityProgram: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    @State private var text: String = ""
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            CustomNavigationBar(headerText: Text("Confirm Program"), rightButtonTextStyle: nil) {
                selectedTab -= 1
            }
            .background(Color("navBarColor"))
            
            Group {
                VStack(alignment: .leading) {
                    Text("Set the name for program")
                        .font(.title3)
                        .fontWeight(.semibold)
                    TextField("Some name", text: $text)
                        .underlineTextField()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black, lineWidth: 1)
            )
            .padding(.horizontal, 8)
            
            Group {
                HStack(alignment: .center) {
                    Text("The day of the program:")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(addNewActivityViewModel.selectedDay.rawValue)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black, lineWidth: 1)
            )
            .padding(.horizontal, 8)
            
            Group {
                VStack(alignment: .leading) {
                    Text("List of exercises:")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(addNewActivityViewModel.finalActivityProgram.indices, id: \.self) { index in
                            HStack {
                                Text(addNewActivityViewModel.finalActivityProgram[index].name)
                                    .foregroundColor(.black)
                                Spacer()
                                Button {
                                    addNewActivityViewModel.finalActivityProgram.remove(at: index)
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("navBarColor"), lineWidth: 1)
                            )
                            .padding(.bottom, 8)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black, lineWidth: 1)
            )
            .padding(.horizontal, 8)
            
            Button {
                print(addNewActivityViewModel.finalActivityProgram.convertToList())
                addNewActivityViewModel.saveNewProgram(
                    program: ExerciseProgram(
                        name: text,
                        dayOfProgram: addNewActivityViewModel.selectedDay.rawValue,
                        exercises: addNewActivityViewModel.finalActivityProgram.convertToList())
                )
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Confirm")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.black)
                    )
                    .padding(.horizontal, 8)
            }
            
            .navigationBarHidden(true)
        }
    }
}

struct ConfirmActivityProgram_Previews: PreviewProvider {
    
    static let viewModel = AddNewActivityViewModel()
    
    static var previews: some View {
        ConfirmActivityProgram(selectedTab: .constant(1))
            .environmentObject(viewModel)
    }
}
