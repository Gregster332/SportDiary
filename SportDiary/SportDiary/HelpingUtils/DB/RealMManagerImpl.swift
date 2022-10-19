import Foundation
import RealmSwift
import SwiftUI

class RealMManagerImpl: RealMManager {

    var realm: Realm
    var exercisesProgram: [ExerciseProgram] = []
    
    init() {
        realm = try! Realm()
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
    
    func getAllExercisesPrograms() -> [ExerciseProgram] {
        let objects = realm.objects(ExerciseProgram.self)
        var newList: [ExerciseProgram] = []
        for obj in objects {
            if !obj.isInvalidated {
                newList.append(obj)
                
            }
        }
        return newList
    }
    
    func deleteObject(exerciseProgram: ExerciseProgram) {
        let id = exerciseProgram._id
        let dbExerciseProgram = realm.object(ofType: ExerciseProgram.self, forPrimaryKey: id)
        if dbExerciseProgram != nil {
            do {
                try realm.write({
                    realm.delete(dbExerciseProgram!)
                })
            } catch {
                fatalError()
            }
        }
    }
    
    func saveExercises(exercises: [Exercise]) {
        do {
            for exercise in exercises {
                try realm.write {
                    realm.add(ExerciseForDB(exercise))
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getObjectsByExercisesIds(ids: [String]) -> [ExerciseForDB] {
        var results: [ExerciseForDB] = []
        for id in ids {
            let object = realm.objects(ExerciseForDB.self).where({
                $0.idOfExercise == id
            }).first!
            results.append(object)
        }
        return results
    }
    
    func getAllExercises() -> [ExerciseForDB] {
        return Array(realm.objects(ExerciseForDB.self))
    }
}

extension RealMManagerImpl {
    func checkDBAlreadyContainsObjectsOf<T: RealmFetchable>(_ type: T.Type) -> Bool {
        let count = realm.objects(type).count
        return count > 0
    }
}
