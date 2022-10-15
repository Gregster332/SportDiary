import Foundation
import RealmSwift

class ExerciseForDB: Object {
    @Persisted var bodyPart: String = ""
    @Persisted var equipment: String = ""
    @Persisted var gifUrl: String = ""
    @Persisted var id: String = ""
    @Persisted var name: String = ""
    @Persisted var target: String = ""
    
    convenience init(
        _ exercise: Exercise
    ) {
        self.init()
        self.bodyPart = exercise.bodyPart
        self.equipment = exercise.equipment
        self.gifUrl = exercise.gifUrl
        self.id = exercise.id
        self.name = exercise.name
        self.target = exercise.target
    }
}

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

class RealMManagerImpl: RealMManager {
    
    let realm = try! Realm()
    
    func saveActivityProgram(_ program: ExerciseProgram) {
        do {
            try realm.write({
                realm.add(program)
            })
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func getAllExercises() -> Results<ExerciseProgram> {
        return realm.objects(ExerciseProgram.self)
    }
    
    func deleteAll() {
        do {
           try realm.write {
                realm.deleteAll()
            }
        } catch {
            fatalError()
        }
    }
    
}

