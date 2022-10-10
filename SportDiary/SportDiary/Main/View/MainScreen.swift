//
//  MainScreen.swift
//  SportDiary
//
//  Created by Grigory Zenkov on 10.10.2022.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        TabView {
            
            ActivityListView()
                .tabItem {
                    Label("Activities", systemImage: "gear")
                }
            
            Text("Hi")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
