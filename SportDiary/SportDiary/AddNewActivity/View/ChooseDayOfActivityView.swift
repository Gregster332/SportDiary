import SwiftUI

struct ChooseDayOfActivityView: View {
    
    @EnvironmentObject var addNewActivityViewModel: AddNewActivityViewModel
    @Environment(\.presentationMode) var presentationMode
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
        
        .navigationBarHidden(true)
    }
}

struct ChooseDayOfActivity_Previews: PreviewProvider {
    
    static let viewModel = AddNewActivityViewModel()
    
    static var previews: some View {
        ChooseDayOfActivityView(selectedTab: .constant(1))
            .environmentObject(viewModel)
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
