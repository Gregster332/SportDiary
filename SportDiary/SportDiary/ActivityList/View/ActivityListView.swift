//
//  ActivityListView.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI

struct ActivityListView: View {
    
    @StateObject var activityListViewModel: ActivityListViewModel = ActivityListViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                HStack {
                    Text("Activity List")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        AddNewActivityView()
                            .navigationBarHidden(true)
                    }, label: {
                        Image(systemName: "plus")
                    })
                    
                }
                .padding(.horizontal, 16)
                
                ScrollView {
                    ForEach(activityListViewModel.dayOfWeeks, id: \.self) { day in
                        ActivityListRowView(activityListRow: ActivityListRow(title: day, exercises: nil))
                    }
                }
                
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
            
            .navigationTitle(Text("Activity List"))
            .navigationBarHidden(true)
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
