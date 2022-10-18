import Foundation

extension ExerciseForDB {
    
    func cast() -> Exercise {
        return Exercise(bodyPart: self.bodyPart,
                        equipment: self.equipment,
                        gifUrl: self.gifUrl,
                        id: self.idOfExercise,
                        name: self.name,
                        target: self.target)
    }
    
}
