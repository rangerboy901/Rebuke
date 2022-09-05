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
    ///JWD:  DELETE WORKOUT
    func deleteWorkout(_ workout: Workout) {
        
        persistentContainer.viewContext.delete(workout)
        do{
             try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to delete workout \(error)")
        }
    }
    ///JWD:  GET WORKOUT BY ID
    func getWorkoutById(id:NSManagedObjectID) -> Workout? {
        do{
            return try persistentContainer.viewContext.existingObject(with: id) as? Workout
        }catch{
           print("error")
            return nil
        }
    }
    ///JWD:  GET ALL WORKOUTS
    func getAllWorkouts() -> [Workout] {
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return[]
        }
    }
    ///JWD:  SAVE
    func save(){
        do{
            try persistentContainer.viewContext.save()
        }catch{
            print("Failed to save \(error)")
        }
    }
}




