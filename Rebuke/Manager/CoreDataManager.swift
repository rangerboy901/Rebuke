//
//  CoreDataManager.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "DailyWorkout")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    //:JWD  GET ALL WORKOUTS
    
    func getAllWorkouts() -> [Workout] {
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return[]
        }
    }
    //JWD:  SAVE
    func save(){
        do{
            try persistentContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
    }
}




