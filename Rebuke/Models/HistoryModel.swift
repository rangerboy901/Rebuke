//
//  HistoryModel.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import Foundation
import CoreData

extension History: BaseModel {
    
    static func getHistoryByWorkoutId(workoutId: NSManagedObjectID) -> [History] {
        
        let request: NSFetchRequest<History> = History.fetchRequest()
        request.predicate = NSPredicate(format: "workout = %@", workoutId)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
}
