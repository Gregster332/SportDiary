import Foundation
import RealmSwift

class ExerciseProgram: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var dayOfProgram: String = ""
    @Persisted var exercises = List<ExerciseForDB>()
    
    convenience init(name: String, dayOfProgram: String, exercises: List<ExerciseForDB>) {
        self.init()
        self.name = name
        self.dayOfProgram = dayOfProgram
        self.exercises = exercises
    }
}
