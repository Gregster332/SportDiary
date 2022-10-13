//
//  AddNewActivitySection.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI

struct AddNewActivityDaySelectionSection: View {
    
    @EnvironmentObject var viewModel: AddNewActivityViewModel
    @State private var toggleDropdownList = false
    
    private let dayOfWeeks: [String] = ["Monday", "Tuesday", "Wednesday", "Thusday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            Button {
                toggleDropdownList.toggle()
            } label: {
                HStack {
                    Text(viewModel.selectedDay.isEmpty ? "Choose the day for new activity" : viewModel.selectedDay)
                        .font(.system(size: 14))
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    
                    Image(systemName: toggleDropdownList ?  "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 9, height: 5)
                        .font(Font.system(size: 9, weight: .medium))
                        .foregroundColor(Color.black)
                }
                .padding(.horizontal)
                .cornerRadius(5)
                .frame(width: .infinity, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 16)
            }
            
            if toggleDropdownList {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(dayOfWeeks, id: \.self) { day in
                            Button {
                                viewModel.selectedDay = day
                                toggleDropdownList.toggle()
                            } label: {
                                Text(day)
                                    .foregroundColor(.black)
                                    .padding(3)
                            }

                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxHeight: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 16)
            }
        }
    }
}

struct AddNewActivitySection_Previews: PreviewProvider {
    
    static let viewModel = AddNewActivityViewModel()
    
    static var previews: some View {
        AddNewActivityDaySelectionSection()
            .environmentObject(viewModel)
    }
}
