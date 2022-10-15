import SwiftUI
import RealmSwift

struct ActivityListRowView: View {
    
    var activityListRow: ActivityListRow
    
    var body: some View {
        VStack {
            HStack {
                Text(activityListRow.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            HStack {
                Text(activityListRow.dayOfWeek)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            Group {
                if let exercises = activityListRow.exercises {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(exercises, id: \.self) { exercise in
                            Text(exercise.name)
                        }
                    }
                } else {
                    Text("No active tasks for today")
                }
            }
            .padding(.vertical, 8)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("navBarColor"), lineWidth: 1)
        )
        .padding(.horizontal, 8)
    }
}

struct ActivityListRow_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListRowView(activityListRow: ActivityListRow(name: "Monday", dayOfWeek: "Monday", exercises: List()))
    }
}
