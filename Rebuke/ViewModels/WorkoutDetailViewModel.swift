//
//  WorkoutDetailViewModel.swift
//  Rebuke
//
//  Created by Joseph William DeWeese on 9/5/22.
//

import Foundation
import SwiftUI
import CoreData



class WorkoutDetailViewModel: ObservableObject {
    
    var title: String = ""
    var objective: String = ""
    var type: String = "HIIT"
    var releaseDate: Date = Date()
    
    let types = ["Strength", "Power", "Cardio", "HIIT", "Recover"]
    
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
        default:
            return .gray
            
        }
    }

    
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
