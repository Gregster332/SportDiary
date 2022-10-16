import SwiftUI
import RealmSwift

enum TabViewItemType: String {
    case activities  = "Activities"
    case healthData   = "Health Data"
    case settings = "Settings"

    var image: Image {
        switch self {
        case .activities:  return Image(systemName: "list.dash")
        case .healthData:   return Image(systemName: "waveform.path.ecg.rectangle")
        case .settings: return Image(systemName: "gearshape.circle.fill")
        }
    }

    var text: Text {
        Text(self.rawValue)
    }
}

struct TabViewItem: View {

    var type: TabViewItemType

    var body: some View {
        VStack {
            type.image
                //.foregroundColor(.orange)
                .renderingMode(.template)
            type.text

        }
    }
}

struct MainScreen: View {

    @StateObject var mainScreenViewModel: MainScreenViewModel = MainScreenViewModel()
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.gray)
    }
    
    var body: some View {
            TabView {
                ActivityListView()
                    .tabItem { TabViewItem(type: .activities) }
                
                Text("Data")
                    .tabItem { TabViewItem(type: .healthData) }
                
                Text("Hi")
                    .tabItem { TabViewItem(type: .settings) }
            }
            .accentColor(Color("navBarColor"))
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
