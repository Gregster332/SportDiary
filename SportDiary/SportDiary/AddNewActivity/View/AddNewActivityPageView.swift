import SwiftUI

struct AddNewActivityPageView: View {
    
    @State private var selectedTab: Int = 0
    @StateObject var addNewActivityViewModel: AddNewActivityViewModel = AddNewActivityViewModel()
    
    var body: some View {
        PageView(selection: $selectedTab, indexDisplayMode: .never, indexBackgroundDisplayMode: .never) {
            ChooseDayOfActivityView(selectedTab: $selectedTab)
                .tag(0)
                
            ChooseSetOfExercisesView(selectedTab: $selectedTab)
                .tag(1)
                
            ConfirmActivityProgram(selectedTab: $selectedTab)
                .tag(2)
                
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(addNewActivityViewModel)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewActivityPageView()
    }
}
