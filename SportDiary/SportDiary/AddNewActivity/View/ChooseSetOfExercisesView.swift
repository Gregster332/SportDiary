import SwiftUI

struct ChooseSetOfExercisesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(headerText: Text("Choose exercises"), rightButtonTextStyle: nil) {
                    withAnimation(.easeInOut) {
                        addNewActivityViewModel.selectedTab -= 1
                    }
                }
                .background(Color("navBarColor"))
                
                if let error = addNewActivityViewModel.isError {
                    Text("Some error here: \(error.localizedDescription)")
                        .frame(maxHeight: .infinity)
                } else if addNewActivityViewModel.isLoading {
                    ProgressView().progressViewStyle(.circular)
                        .frame(maxHeight: .infinity)
                } else if !addNewActivityViewModel.fetchedExercises.isEmpty {
                    ZStack(alignment: .bottom) {
                        VStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .font(.title3)
                                TextField("Search...", text: $addNewActivityViewModel.searchedText)
                                    .textInputAutocapitalization(.never)
                            }
                            .padding()
                            .modifier(BackgroundRounded(strokeColor: Color("navBarColor")))
                            .padding(.horizontal, 8)
                            
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(addNewActivityViewModel.serchedResults) { exercise in
                                        ExerciseView(
                                            exercise: exercise
                                        )
                                    }
                                }
                                .padding(.top, 8)
                            }
                        }
                        
                        Button {
                            withAnimation(.easeInOut) {
                                addNewActivityViewModel.nextButtonTapped()
                            }
                        } label: {
                            Text("Next")
                                .foregroundColor(colorScheme == .light ? .white : .black)
                                .frame(maxWidth: .infinity, maxHeight: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(colorScheme == .light ? .black : .white)
                                )
                                .padding(.horizontal)
                        }
                        .alert("List of exercises is empty", isPresented: $addNewActivityViewModel.showListIsEmptyAlert, actions: {
                            Button("OK", role: .cancel) {
                                addNewActivityViewModel.showListIsEmptyAlert = false
                            }
                        }, message: {
                            Text("Choose some exercises first and then tap Next button")
                        })
                    }
                }
            }
        }
        .onAppear {
            addNewActivityViewModel.getAllExercises()
        }
        
        .navigationBarHidden(true)
    }
}

struct AddNewActivityView_Previews: PreviewProvider {
    static let viewModel = AddNewActivityViewModel(networkManager: NetworkManagerImpl(), realmManager: RealMManagerImpl())
    static var previews: some View {
        ChooseSetOfExercisesView()
            .environmentObject(viewModel)
    }
}
