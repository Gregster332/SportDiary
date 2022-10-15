//
//  MainScreen.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var selection = ""
    @StateObject var mainScreenViewModel: MainScreenViewModel = MainScreenViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                
                ActivityListView()
                    .tabItem {
                        Label("Activities", systemImage: "gear")
                    }
                    .onAppear {
                        selection = "Activities"
                    }
                
                Text("Hi")
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .onAppear {
                        selection = "Settings"
                    }
                
            }
            
            .navigationBarTitle(selection)
            .toolbar {
                Button {
                    mainScreenViewModel.addNewActivityProgramIsOpen = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color("navBarColor"))
                }

            }
            .fullScreenCover(isPresented: $mainScreenViewModel.addNewActivityProgramIsOpen) {
                AddNewActivityPageView()
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
