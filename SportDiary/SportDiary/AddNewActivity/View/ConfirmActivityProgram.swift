import SwiftUI
import RealmSwift

struct ConfirmActivityProgram: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    @State private var text: String = ""
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            CustomNavigationBar(headerText: Text("Confirm Program"), rightButtonTextStyle: nil) {
                withAnimation(.easeInOut) {
                    selectedTab -= 1
                }
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
            .modifier(Rounded(strokeColor: colorScheme == .light ? Color.black : Color.white))
            
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
            .modifier(Rounded(strokeColor: colorScheme == .light ? Color.black : Color.white))
            
            Group {
                VStack(alignment: .leading) {
                    Text("List of exercises:")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(addNewActivityViewModel.finalActivityProgram.indices, id: \.self) { index in
                            HStack {
                                Text(addNewActivityViewModel.finalActivityProgram[index].name)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
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
                            .modifier(BackgroundRounded(strokeColor: Color("navBarColor")))
                        }
                    }
                    .padding(.vertical, 8)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            .modifier(Rounded(strokeColor: colorScheme == .light ? Color.black : Color.white))
            
            Button {
                if !addNewActivityViewModel.finalActivityProgram.isEmpty {
                    if text.isEmpty {
                        addNewActivityViewModel.showListIsEmptyAlert = true
                    } else {
                        addNewActivityViewModel.saveNewProgram(
                            program: ExerciseProgram(
                                name: text,
                                dayOfProgram: addNewActivityViewModel.selectedDay.rawValue,
                                exercises: addNewActivityViewModel.finalActivityProgram.convertToList())
                        )
                        withAnimation(.easeInOut) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                } else {
                    addNewActivityViewModel.showListIsEmptyAlert = true
                }
            } label: {
                Text("Confirm")
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(colorScheme == .light ? .black : .white)
                    )
                    .padding(.horizontal, 8)
            }
            .alert(!text.isEmpty ? "No exercises in list and you should choose some. Tap OK and choose exercises." : "Name of program is empty. Please type something.", isPresented: $addNewActivityViewModel.showListIsEmptyAlert, actions: {
                Button("OK", role: .cancel) {
                    if !text.isEmpty {
                        withAnimation(.easeInOut) {
                            selectedTab -= 1
                        }
                    }
                }
            })
            
            .navigationBarHidden(true)
        }
    }
}

struct ConfirmActivityProgram_Previews: PreviewProvider {
    
    static let viewModel = AddNewActivityViewModel()
    
    static var previews: some View {
        ConfirmActivityProgram(selectedTab: .constant(1))
            .preferredColorScheme(.dark)
            .environmentObject(viewModel)
    }
}
