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
                
                if !addNewActivityViewModel.isLoading {
                    ZStack(alignment: .bottom) {
                        VStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .font(.title3)
                                TextField("Search...", text: $addNewActivityViewModel.searchedText)
                                    .textInputAutocapitalization(.never)
                                    .onSubmit {
                                        addNewActivityViewModel.getAllExercises()
                                        addNewActivityViewModel.fetchedExercises = addNewActivityViewModel.fetchedExercises.filter({$0.name.contains(addNewActivityViewModel.searchedText)})
                                    }
                            }
                            .padding()
                            .modifier(BackgroundRounded(strokeColor: Color("navBarColor")))
                            .padding(.horizontal, 8)
                            
                            if !addNewActivityViewModel.searchedText.isEmpty {
                                if !addNewActivityViewModel.fetchedExercises.isEmpty {
                                    ScrollView {
                                        VStack(spacing: 16) {
                                            ForEach(addNewActivityViewModel.fetchedExercises) { exercise in
                                                ExerciseView(
                                                    exercise: exercise
                                                )
                                            }
                                        }
                                        .padding(.top, 8)
                                    }
                                } else {
                                    Text("Type something and submit in search text field to find exercises")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            } else {
                                VStack {
                                    ScrollView {
                                        VStack(spacing: 16) {
                                            ForEach(addNewActivityViewModel.targets, id: \.self) { target in
                                                TargetView(target: target)
                                            }
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
                                    
                                }
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
                } else {
                    ProgressView().progressViewStyle(.circular)
                        .frame(maxHeight: .infinity)
                }
            }
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
