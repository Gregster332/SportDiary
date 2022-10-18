import SwiftUI
import RealmSwift

struct ActivityListRowView: View {
    
    var activityListRow: ActivityListRow
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
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
                }
            }
            
            Group {
                if let exercises = activityListRow.exercises {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(exercises, id: \.self) { exercise in
                            HStack {
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("Exercise name: \(exercise.name)")
                                    Text("Target: \(exercise.target)")
                                    Text("Body part: \(exercise.bodyPart)")
                                    Text("Equipment: \(exercise.equipment)")
                                }
                                
                                Spacer()
                                
                                GIFView(type: .url(URL(string: exercise.gifUrl)!))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150, alignment: .center)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("navBarColor"), lineWidth: 1)
                            )
                            .padding(.horizontal, 8)
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
        .modifier(Rounded(strokeColor: colorScheme == .light ? .black : .white, strokeLineWidth: 2))
    }
}

struct ActivityListRow_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListRowView(activityListRow: ActivityListRow(name: "Monday", dayOfWeek: "Monday", exercises: List()))
    }
}
