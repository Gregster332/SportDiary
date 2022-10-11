//
//  AddNewActivityView.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI

struct AddNewActivityView: View {
    
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
                ScrollView {
                    VStack(spacing: 16) {
                        HStack(alignment: .top) {
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.blue)
                            }
                            
                            Text("Let's add new activity program!")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        AddNewActivityDaySelectionSection(selectedDay: $addNewActivityViewModel.selectedDay)
                        
                        ForEach(exercises) { exercise in
                            VStack {
                                Text(exercise.name)
                                Text(exercise.bodyPart)
                                Text(exercise.equipment)
                                Text(exercise.target)
                            }
                            .background(Color.red)
                            //Text(exercise.)
                        }
                    }
                    .padding(.top, 8)
                    
                }
                .background(.black.opacity(0.1))
            }
        }
        .task {
            try? await addNewActivityViewModel.getListOfAllExercises()
        }
        .environmentObject(addNewActivityViewModel)
        
    }
}

struct AddNewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewActivityView()
    }
}
