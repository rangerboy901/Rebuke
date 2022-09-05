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
    
    @Published var workouts = [WorkoutViewModel]()
    
    func colorize(type: String) -> Color {
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
    func deleteWorkout(workout: WorkoutViewModel) {
        let workout: Workout? = Workout.byId(id: workout.workoutId)
        if let workout = workout {
            try? workout.delete()
        }
    }
    
    func getAllWorkouts() {
        DispatchQueue.main.async {
            self.workouts = Workout.all().map(WorkoutViewModel.init)
        }
    }
}

struct WorkoutViewModel {
    
    let workout: Workout
    
    var workoutId: NSManagedObjectID {
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


