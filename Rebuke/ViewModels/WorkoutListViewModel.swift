//
//  WorkoutListViewModel.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import Foundation
import CoreData
import SwiftUI

class WorkoutListViewModel: ObservableObject {
  ///JWD:  PROPERTIES
    @Published var workouts = [WorkoutViewModel]()
    
   ///JWD:  COLORIZING FUNCTION FOR WORKOUT TYPE
    func Colorize(type: String) -> Color {
        switch type {
        case "HIIT":
            return .blue
        case "Strength":
            return .orange
        case "Cardio":
            return .pink
        case "Power":
            return .green
        case "Recover":
            return .mint
        default:
            return .gray
            
        }
    }
    ///JWD:  DELETE WORKOUT
    func deleteWorkout(workout: WorkoutViewModel) {
        let workout = CoreDataManager.shared.getWorkoutById(id: workout.id)
        if let workout = workout {
            CoreDataManager.shared.deleteWorkout(workout)
        }
    }
    ///JWD:   GET ALL WORKOUTS
    func getAllWorkouts() {
        
        _ = CoreDataManager.shared.getAllWorkouts()
        DispatchQueue.main.async {
            self.workouts = Workout.all().map(WorkoutViewModel.init)
        }
    }
}
///JWD:  WORKOUT VIEW MODEL
struct WorkoutViewModel {
    
    let workout: Workout
    
    var workoutId: NSManagedObjectID {
        return workout.objectID
    }
    var id: NSManagedObjectID {
        return workout.objectID
    }
    
    var title: String {
        return workout.title ?? ""
    }
    
    var objective: String {
        return workout.objective ?? "Not available"
    }
    var type: String {
        return workout.type ?? "Not available"
    }
    
    var releaseDate: String? {
        return workout.releaseDate?.asFormattedString()
    }
}

