//
//  AddNewActivitySection.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI

struct AddNewActivityDaySelectionSection: View {
    
    @Binding var selectedDay: String
    
    private let dayOfWeeks: [String] = ["Monday", "Tuesday", "Wednesday", "Thusday", "Friday", "Saturday", "Sunday"]
    private let rows = [
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15))
        ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                Text("First, select day of activity")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal, 8)
            
            HStack {
                Spacer()
                LazyHGrid(rows: rows, spacing: 10) {
                    
                    ForEach(dayOfWeeks, id: \.self) { day in
                        
                        Button {
                            selectedDay = day
                        } label: {
                            HStack {
                            Image(systemName: selectedDay == day ? "circle.fill" : "circle")
                                .foregroundColor(selectedDay == day ? .green : .black)
                            Text(day)
                                .font(.subheadline)
                                .foregroundColor(.black)
                            }
                            .frame(width: 110, alignment: .leading)
                        }
                    }
                }
            }
            
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .padding(.horizontal, 8)
    }
}

struct AddNewActivitySection_Previews: PreviewProvider {
    static var previews: some View {
        AddNewActivityDaySelectionSection(selectedDay: .constant("Monday"))
    }
}
