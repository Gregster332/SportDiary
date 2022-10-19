import SwiftUI

struct UserHealthViewNew: View {
    
    @StateObject var userHealthViewModel: UserHealthViewModel = Resolver.shared.resolve(UserHealthViewModel.self)
    
    var body: some View {
        NavigationView {
            VStack {
                StepsView()
                    
                Spacer()
            }
            
            .navigationTitle("Profile")
            .toolbar {
                Button {
                    //
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color("navBarColor"))
                }

            }
        }
        .environmentObject(userHealthViewModel)
    }
}

struct UserHealthViewNew_Previews: PreviewProvider {
    static var previews: some View {
        UserHealthViewNew()
    }
}
