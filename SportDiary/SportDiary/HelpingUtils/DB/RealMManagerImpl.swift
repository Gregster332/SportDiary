import Foundation
import RealmSwift

class RealMManagerImpl: RealMManager {
    
    var realm: Realm
    var exercisesProgram: [ExerciseProgram] = []
    
    init() {
        realm = try! Realm()
        
//        do {
//            try realm.write({
//                realm.create(ExerciseProgram.self)
//            })
//        } catch let error {
//            fatalError(error.localizedDescription)
//        }
    }
    
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
    
    func deleteObject(exerciseProgram: ExerciseProgram) {
        let id = exerciseProgram._id
        let dbExerciseProgram = realm.object(ofType: ExerciseProgram.self, forPrimaryKey: id)
        if dbExerciseProgram != nil {
            do {
                try realm.write({
                    for exercise in dbExerciseProgram!.exercises {
                        realm.delete(exercise)
                    }
                    realm.delete(dbExerciseProgram!)
                })
            } catch {
                fatalError()
            }
        }
    }
    
}
