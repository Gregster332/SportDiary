//
//  ExerciseView.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 07.10.2022.
//

import SwiftUI

struct ExerciseView: View {

    let exercise: Exercise
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel

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
                    addNewActivityViewModel.openForMoreInformation.toggle()
                } label: {
                    HStack {
                        Text(addNewActivityViewModel.openForMoreInformation ? "Close" : "More information")
                        Image(systemName: addNewActivityViewModel.openForMoreInformation ? "arrow.turn.right.up" : "arrow.turn.right.down")
                    }
                    .foregroundColor(.indigo)
                }
                .padding(.trailing, 8)
            }
            
            if !addNewActivityViewModel.openForMoreInformation {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Body part: \(exercise.bodyPart)")
                            .fontWeight(.medium)
                        Text("Equipment: \(exercise.equipment)")
                            .fontWeight(.medium)
                    }
                    .font(.body)
                    
                    
                    
                }
                .padding(.horizontal, 16)
            }
            
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.09))
        .cornerRadius(10)
        .padding(.horizontal, 8)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    
    static let envObject = AddNewActivityViewModel()
    
    static var previews: some View {
        ExerciseView(exercise: Exercise(
            bodyPart:"waist",
            equipment:"body weight",
            gifUrl:"http://d205bpvrqc9yn1.cloudfront.net/0001.gif",
            id:"0001",
            name:"3/4 sit-up",
            target:"abs"
        )).environmentObject(envObject)
    }
}
