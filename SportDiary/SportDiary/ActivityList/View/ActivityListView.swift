import SwiftUI
import RealmSwift

struct ActivityListView: View {
    
    @StateObject var activityListViewModel: ActivityListViewModel = Resolver.shared.resolve(ActivityListViewModel.self)
    
    var body: some View {
        NavigationView {
            VStack {
                    ScrollView {
                        ForEach(activityListViewModel.exercisesPrograms.indices, id: \.self) { index in
                            ZStack(alignment: .topTrailing) {
                                ActivityListRowView(
                                    activityListRow: ActivityListRow(
                                        name: activityListViewModel.exercisesPrograms[index].name,
                                        dayOfWeek: activityListViewModel.exercisesPrograms[index].dayOfProgram,
                                        exercises: activityListViewModel.getExercisesByExercisesIds(ids: Array(activityListViewModel.exercisesPrograms[index].idsOfExercises))
                                    )
                                )
                                if index == activityListViewModel.exercisesPrograms.count - 1 {
                                    Button {
                                        withAnimation(.easeInOut) {
                                            activityListViewModel.deleteExerciseProgram(program: activityListViewModel.exercisesPrograms[index],
                                                                                        index: index)
                                        }
                                    } label: {
                                        Image(systemName: "trash.circle.fill")
                                            .font(.title)
                                            .foregroundColor(.red)
                                    }
                                    .padding(.trailing)
                                    .padding(.top)
                                } else {
                                    Text("Delete other first")
                                        .padding(.trailing)
                                        .padding(.top)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 8)
            .padding(.bottom, 8)
            
            .navigationTitle("Activities")
            .toolbar {
                Button {
                    activityListViewModel.addNewActivityProgramIsOpen = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color("navBarColor"))
                }

            }
            .fullScreenCover(isPresented: $activityListViewModel.addNewActivityProgramIsOpen) {
                AddNewActivityPageView()
                    .onDisappear {
                        activityListViewModel.getAllExercisesPrograms()
                    }
            }
            .onAppear {
                activityListViewModel.getAllExercisesPrograms()
            }
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
