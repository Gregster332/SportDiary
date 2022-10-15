//
//  ActivityListView.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI
import RealmSwift

struct ActivityListView: View {
    
    @StateObject var activityListViewModel: ActivityListViewModel = ActivityListViewModel()
    
    var body: some View {
            VStack {
                ScrollView {
                    ForEach(activityListViewModel.exercisesPrograms, id: \.self) { program in
                        ActivityListRowView(
                            activityListRow: ActivityListRow(
                                name: program.name,
                                dayOfWeek: program.dayOfProgram,
                                exercises: program.exercises
                            )
                        )
                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
            .onAppear {
                activityListViewModel.getAllExercisesPrograms()
            }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}

enum DayOfWeek: String, CaseIterable {
    static var allCases: [DayOfWeek] {
        return [.monday, .tuesday, .wednesday, .tuesday, .friday, .saturday, .sunday]
    }
    
    case monday = "Monday",
         tuesday = "Tuesday",
         wednesday = "Wednesday",
         thusday = "Thusday",
         friday = "Friday",
         saturday = "Saturday",
         sunday = "Sunday"
    case none
    
}
