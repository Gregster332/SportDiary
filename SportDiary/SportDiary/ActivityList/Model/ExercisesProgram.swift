import Foundation
import RealmSwift

class ExerciseProgram: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var dayOfProgram: String = ""
    @Persisted var idsOfExercises = List<String>()
    
    convenience init(name: String, dayOfProgram: String, idsOfExercises: List<String>) {
        self.init()
        self.name = name
        self.dayOfProgram = dayOfProgram
        self.idsOfExercises = idsOfExercises
    }
}
