//
//  WorkoutEditViewModel.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 9/4/22.
//

import Foundation
import CoreData


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
    
    
    
    
    func save() {
        
        let workout = Workout(context: Workout.viewContext)
        workout.title = title
        workout.objective = objective
        workout.type = type
        workout.releaseDate = releaseDate
        
        try? workout.save()
    }
   
        struct Data {
            var title: String = ""
            var objective: String = ""
            var type: String = ""
        }
        
        var data: Data {
            return Data(title: title, objective: objective, type: type)
        }
        
        func update(from data: Data) {
            title = data.title
            objective = data.objective
            type = data.type
            //        for attendee in data.attendees {
            //            if !attendees.contains(attendee) {
            //                self.attendeeList.append(attendee)
            //            }
            //        }
            
        }
    }

