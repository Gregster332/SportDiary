//
//  ChooseDayOfActivity.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 13.10.2022.
//

import SwiftUI

struct ChooseDayOfActivityView: View {
    
    @StateObject var addNewActivityViewModel: AddNewActivityViewModel = AddNewActivityViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            CustomNavigationBar(headerText: Text("Choose day"), rightButtonTextStyle: nil) {
                presentationMode.wrappedValue.dismiss()
            }
            .background(Color("navBarColor"))
            
            AddNewActivityDaySelectionSection()
            
            if !addNewActivityViewModel.selectedDay.isEmpty {
                NavigationLink {
                    ChooseSetOfExercisesView()
                        
                } label: {
                    Text("Next")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("navBarColor"), lineWidth: 1)
                        )
                        .padding(.horizontal)
                }

            }
            
            Spacer()
        }
        .environmentObject(addNewActivityViewModel)
        
        .navigationBarHidden(true)
    }
}

struct ChooseDayOfActivity_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDayOfActivityView()
    }
}


struct CustomNavigationBar: View {
    
    let headerText: Text
    let rightButtonTextStyle: Button<Text>?
    let goBackAction: () -> Void
    
    var body: some View {
        HStack {
            Button {
                goBackAction()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .frame(width: 24,
                           height: 24)
            }
            
            Spacer()
            
            if rightButtonTextStyle == nil {
            headerText
                .font(.headline)
                .foregroundColor(.black)
                .padding(.trailing, 24)
            }
            
            Spacer()
            
            if rightButtonTextStyle != nil {
                rightButtonTextStyle
            }
        }
        .frame(height: 42)
        .padding(.horizontal)
    }
}
