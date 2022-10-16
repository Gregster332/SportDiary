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
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            Button {
                withAnimation(.easeInOut) {
                    toggleDropdownList.toggle()
                }
            } label: {
                HStack {
                    Text(viewModel.selectedDay == .none ? "Choose the day for new activity" : viewModel.selectedDay.rawValue)
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
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 16)
            }
            
            if toggleDropdownList {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(DayOfWeek.allCases, id: \.self) { day in
                            Button {
                                withAnimation(.easeInOut) {
                                    viewModel.selectedDay = day
                                    toggleDropdownList.toggle()
                                }
                            } label: {
                                Text(day.rawValue)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10).fill(.thinMaterial)
                                    )
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 8)
                                    
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
