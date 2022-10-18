import SwiftUI

struct AddNewActivityDaySelectionSection: View {
    
    @EnvironmentObject var viewModel: AddNewActivityViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var toggleDropdownList = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            Button {
                withAnimation(.easeInOut) {
                    toggleDropdownList.toggle()
                }
            } label: {
                HStack {
                    Text(viewModel.selectedDay == .none ? "Choose the day for new activity" : viewModel.selectedDay.rawValue)
                        .font(.system(size: 14))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                    
                    Spacer()
                    
                    Image(systemName: toggleDropdownList ?  "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 9, height: 5)
                        .font(Font.system(size: 9, weight: .medium))
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
                .padding(.horizontal)
                .cornerRadius(5)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .modifier(Rounded(strokeColor: .gray, padding: 16))
            }
            
            if toggleDropdownList {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(DayOfWeek.allCases, id: \.self) { day in
                            Button {
                                withAnimation(.easeInOut) {
                                    viewModel.selectedDay = day
                                    toggleDropdownList.toggle()
                                }
                            } label: {
                                Text(day.rawValue)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10).fill(.thinMaterial)
                                    )
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 8)
                                    
                            }

                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxHeight: 150)
                .modifier(Rounded(strokeColor: .gray, padding: 16))
            }
        }
    }
}

struct AddNewActivitySection_Previews: PreviewProvider {
    
    static let viewModel = AddNewActivityViewModel(networkManager: NetworkManagerImpl(), realmManager: RealMManagerImpl())
    
    static var previews: some View {
        AddNewActivityDaySelectionSection()
            .preferredColorScheme(.dark)
            .environmentObject(viewModel)
    }
}
