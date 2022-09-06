//
//  WorkoutEditViewModel.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 9/4/22.
//

import Foundation
import CoreData
import SwiftUI

class WorkoutEditViewModel: ObservableObject {
    
    var title: String = ""
    var objective: String = ""
    var type: String = ""
    var releaseDate: Date = Date()
    
    convenience init(title: String, Objective: [String], type: String) {
        self.init()
        self.title = title
        self.objective = objective
        self.type = type
        self.releaseDate = releaseDate
    }
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
    
    struct Data {
        var title: String = ""
        var objective: String = ""
        var type: String = ""
    }
    
    var data: Data {
        return Data(title: title, objective: objective, type: type)
    }
    
        //        for attendee in data.attendees {
        //            if !attendees.contains(attendee) {
        //                self.attendeeList.append(attendee)
        //            }
        //        }
        
    }

extension Workout {
    struct Data {
        var title: String = ""
        var objective: String = ""
        var type: String = ""
       
    }

    var data: Data {
        return Data(title: title!, objective: objective!, type: type!)
    }
    
    func update(from data: Data) {
        title = data.title
        objective = data.objective
        type = data.type
            }
        }
        
       

