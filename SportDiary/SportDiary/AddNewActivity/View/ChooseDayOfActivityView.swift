import SwiftUI

struct ChooseDayOfActivityView: View {
    
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            CustomNavigationBar(headerText: Text("Choose day"), rightButtonTextStyle: nil) {
                withAnimation(.easeInOut) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .background(Color("navBarColor"))
            
            AddNewActivityDaySelectionSection()
            
            if addNewActivityViewModel.selectedDay != .none {
                Button {
                    withAnimation(.easeInOut) {
                        selectedTab += 1
                    }
                } label: {
                    Text("Next")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .background(colorScheme == .light ? .clear : Color("navBarColor"))
                        .modifier(Rounded(strokeColor: Color("navBarColor"), padding: 16))
                }
                
            }
            
            Spacer()
        }
        
        .navigationBarHidden(true)
    }
}

struct ChooseDayOfActivity_Previews: PreviewProvider {
    
    static let viewModel = AddNewActivityViewModel()
    
    static var previews: some View {
        ChooseDayOfActivityView(selectedTab: .constant(1))
            .preferredColorScheme(.dark)
            .environmentObject(viewModel)
    }
}
