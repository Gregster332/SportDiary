import SwiftUI

struct CustomNavigationBar: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let headerText: Text
    let rightButtonTextStyle: Button<Text>?
    let goBackAction: () -> Void
    
    var body: some View {
        HStack {
            Button {
                goBackAction()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(colorScheme == .light ? .black : .white)
                    .frame(width: 24,
                           height: 24)
            }
            
            Spacer()
            
            if rightButtonTextStyle == nil {
            headerText
                .font(.headline)
                .foregroundColor(colorScheme == .light ? .black : .white)
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

