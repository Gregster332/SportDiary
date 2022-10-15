import SwiftUI
import RealmSwift

struct MainScreen: View {

    @StateObject var mainScreenViewModel: MainScreenViewModel = MainScreenViewModel()
    
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
            .onAppear {
                print(Realm.Configuration.defaultConfiguration.fileURL)
            }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
