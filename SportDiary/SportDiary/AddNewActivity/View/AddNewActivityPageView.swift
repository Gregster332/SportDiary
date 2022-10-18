import SwiftUI

struct AddNewActivityPageView: View {
    
    @StateObject var addNewActivityViewModel: AddNewActivityViewModel = Resolver.shared.resolve(AddNewActivityViewModel.self)
    
    var body: some View {
        PageView(selection: $addNewActivityViewModel.selectedTab, indexDisplayMode: .never, indexBackgroundDisplayMode: .never) {
            ChooseDayOfActivityView()
                .tag(0)
                
            ChooseSetOfExercisesView()
                .tag(1)
                
            ConfirmActivityProgram()
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
