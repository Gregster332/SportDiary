import SwiftUI

struct ChooseSetOfExercisesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    @State private var searchedText: String = ""
    @Binding var selectedTab: Int
    
    var serchedResults: [Exercise] {
        if searchedText.isEmpty {
            return addNewActivityViewModel.fetchedExercises
        } else {
            return addNewActivityViewModel.fetchedExercises
                .filter({$0.name.contains(searchedText)})
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(headerText: Text("Choose exercises"), rightButtonTextStyle: nil) {
                    withAnimation(.easeInOut) {
                        selectedTab -= 1
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
                                TextField("Search...", text: $searchedText)
                                    .textInputAutocapitalization(.never)
                            }
                            .padding()
                            .modifier(BackgroundRounded(strokeColor: Color("navBarColor")))
                            
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(serchedResults) { exercise in
                                        ExerciseView(
                                            exercise: exercise
                                        )
                                    }
                                }
                                .padding(.top, 8)
                            }
                        }
                        
                        Button {
                            if !addNewActivityViewModel.finalActivityProgram.isEmpty {
                                withAnimation(.easeInOut) {
                                    selectedTab += 1
                                }
                            } else {
                                addNewActivityViewModel.showListIsEmptyAlert = true
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
        .task {
            if addNewActivityViewModel.isLoadingNeeded {
                try? await addNewActivityViewModel.getListOfAllExercises()
            }
        }
        
        .navigationBarHidden(true)
    }
}

struct AddNewActivityView_Previews: PreviewProvider {
    static let viewModel = AddNewActivityViewModel()
    static var previews: some View {
        ChooseSetOfExercisesView(selectedTab: .constant(1))
            .environmentObject(viewModel)
    }
}
