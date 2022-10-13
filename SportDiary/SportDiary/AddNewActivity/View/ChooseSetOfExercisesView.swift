//
//  AddNewActivityView.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI

struct ChooseSetOfExercisesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addNewActivityViewModel: AddNewActivityViewModel = AddNewActivityViewModel()
    
    var body: some View {
        ZStack {
            switch addNewActivityViewModel.addNewActivityViewState {
            case .notStartedAnyTask, .loading:
                ProgressView().progressViewStyle(.circular)
            case .failure(let error):
                Text("Some error here: \(error.localizedDescription)")
            case .success(let exercises):
                ZStack(alignment: .bottom) {
                    VStack {
                        CustomNavigationBar(headerText: Text("Choose exercises"), rightButtonTextStyle: nil) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .background(Color("navBarColor"))
                        
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(exercises) { exercise in
                                    ExerciseView(
                                        exercise: exercise
                                    )
                                }
                            }
                            .padding(.top, 8)
                        }
                    }
                    
                    Button {
                        //
                    } label: {
                        Rectangle()
                    }

                }
                .task {
                    try? await addNewActivityViewModel.getListOfAllExercises()
                }
                .environmentObject(addNewActivityViewModel)
            }
        }
        
        .navigationBarHidden(true)
    }
}

struct AddNewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseSetOfExercisesView()
    }
}
