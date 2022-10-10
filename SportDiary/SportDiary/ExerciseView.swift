//
//  ExerciseView.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 07.10.2022.
//

import SwiftUI

struct ExerciseView: View {
    
    let exercise: Exercise
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.title2)
                Text(exercise.equipment)
                    .font(.title2)
            }
            
            Text(exercise.target)
        }
        .frame(maxWidth: .infinity)
        .background(Color.red.cornerRadius(10))
        .padding(.horizontal)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(exercise: Exercise(
            bodyPart:"waist",
            equipment:"body weight",
            gifUrl:"http://d205bpvrqc9yn1.cloudfront.net/0001.gif",
            id:"0001",
            name:"3/4 sit-up",
            target:"abs"
        ))
    }
}
