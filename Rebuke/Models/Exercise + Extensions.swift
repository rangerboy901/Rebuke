//
//  Exercise + Extensions.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import Foundation
import CoreData

extension Exercise: BaseModel {
    
    static func getExercisesByWorkoutId(workoutId: NSManagedObjectID) -> [Exercise] {
        guard let workout = Workout.byId(id: workoutId) as? Workout,
              let exercises = workout.exercises
               
        else {
            return []
        }
        
        return []
    }
    
}
