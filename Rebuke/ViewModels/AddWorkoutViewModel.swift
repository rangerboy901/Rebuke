//
//  AddWorkoutViewModel.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import Foundation

class AddWorkoutViewModel: ObservableObject {
    
    var title: String = ""
    var objective: String = ""
    var type: String = "HIIT"
    var releaseDate: Date = Date()
    
    let types = ["Strength", "Power", "Cardio", "HIIT", "Recover"]
    
    func save() {
        let manager = CoreDataManager.shared
        let workout = Workout(context: manager.persistentContainer.viewContext)
        workout.title = title
        workout.objective = objective
        workout.type = type
        workout.releaseDate = releaseDate
        
        manager.save()
    }
    
}
