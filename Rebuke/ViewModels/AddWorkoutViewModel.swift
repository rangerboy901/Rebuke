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
    var type: String = ""
    var releaseDate: Date = Date()
    
    func save() {
        
        let workout = Workout(context: Workout.viewContext)
        workout.title = title
        workout.objective = objective
        workout.type = type
        workout.releaseDate = releaseDate
        
        try? workout.save()
    }
    
}
