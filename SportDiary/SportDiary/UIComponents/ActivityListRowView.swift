//
//  ActivityListRow.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI

struct ActivityListRowView: View {
    
    var activityListRow: ActivityListRow
    
    var body: some View {
        VStack {
            HStack {
                Text(activityListRow.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            Group {
                if activityListRow.exercises == nil {
                    Text("No active tasks for today")
                } else {
                    Text("Execrcises here")
                }
            }
            .padding(.vertical, 8)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
        .padding(.horizontal, 8)
    }
}

struct ActivityListRow_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListRowView(activityListRow: ActivityListRow(title: "Monday", exercises: nil))
    }
}
