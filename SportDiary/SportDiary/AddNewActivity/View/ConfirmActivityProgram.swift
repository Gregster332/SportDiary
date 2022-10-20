import SwiftUI
import RealmSwift

struct ConfirmActivityProgram: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    
    var body: some View {
        VStack {
            CustomNavigationBar(headerText: Text("Confirm Program"), rightButtonTextStyle: nil) {
                withAnimation(.easeInOut) {
                    addNewActivityViewModel.selectedTab -= 1
                }
            }
            .background(Color("navBarColor"))
            
            Group {
                VStack(alignment: .leading) {
                    Text("Set the name for program")
                        .font(.title3)
                        .fontWeight(.semibold)
                    TextField("Some name", text: $addNewActivityViewModel.nameOfProgram)
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
                        ForEach(addNewActivityViewModel.finalActivityProgramIds.indices, id: \.self) { index in
                            HStack {
                                Text(addNewActivityViewModel.getExerciseByExerciseId(
                                    id: addNewActivityViewModel.finalActivityProgramIds[index]
                                ).name)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                Spacer()
                                Button {
                                    addNewActivityViewModel.finalActivityProgramIds.remove(at: index)
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
                if !addNewActivityViewModel.finalActivityProgramIds.isEmpty {
                    if addNewActivityViewModel.nameOfProgram.isEmpty {
                        addNewActivityViewModel.showListIsEmptyAlert = true
                    } else {
                        addNewActivityViewModel.saveNewProgram(
                            program: ExerciseProgram(
                                name: addNewActivityViewModel.nameOfProgram,
                                dayOfProgram: addNewActivityViewModel.selectedDay.rawValue,
                                idsOfExercises: addNewActivityViewModel.finalActivityProgramIds.convertToList())
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
            .alert(!addNewActivityViewModel.nameOfProgram.isEmpty ? "No exercises in list and you should choose some. Tap OK and choose exercises." : "Name of program is empty. Please type something.", isPresented: $addNewActivityViewModel.showListIsEmptyAlert, actions: {
                Button("OK", role: .cancel) {
                    if !addNewActivityViewModel.nameOfProgram.isEmpty {
                        withAnimation(.easeInOut) {
                            addNewActivityViewModel.selectedTab -= 1
                        }
                    }
                }
            })
            
            .navigationBarHidden(true)
        }
    }
}

struct ConfirmActivityProgram_Previews: PreviewProvider {
    
    static let viewModel = AddNewActivityViewModel(networkManager: NetworkManagerImpl(), realmManager: RealMManagerImpl())
    
    static var previews: some View {
        ConfirmActivityProgram()
            .preferredColorScheme(.dark)
            .environmentObject(viewModel)
    }
}
