import Foundation
import RealmSwift

class ExerciseForDB: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var bodyPart: String = ""
    @Persisted var equipment: String = ""
    @Persisted var gifUrl: String = ""
    @Persisted var idOfExercise: String = ""
    @Persisted var name: String = ""
    @Persisted var target: String = ""
    
    convenience init(
        _ exercise: Exercise
    ) {
        self.init()
        self.bodyPart = exercise.bodyPart
        self.equipment = exercise.equipment
        self.gifUrl = exercise.gifUrl
        self.idOfExercise = exercise.id
        self.name = exercise.name
        self.target = exercise.target
    }
}
