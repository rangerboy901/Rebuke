//
//  WorkoutListView.swift
//  Rebuke
//
//  Created by Joseph William DeWeese on 8/24/22.
//

import SwiftUI

struct WorkoutListScreen: View {
   ///JWD:  PROPERTIES
    @StateObject private var workoutListVM = WorkoutListViewModel()
    @State private var isPresented: Bool = false

    private func deleteWorkout(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let workout = workoutListVM.workouts[index]
            // delete the workout
            workoutListVM.deleteWorkout(workout: workout)
            // get all workouts
            workoutListVM.getAllWorkouts()
        }
    }
    var body: some View {
        ///JWD:  WORKOUT LIST
        List {
            ForEach(workoutListVM.workouts, id: \.workoutId) { workout in
                NavigationLink(
                    destination: WorkoutDetailScreen(workout: workout),
                    label: {
                        WorkoutCell(workout: workout)
                    })
            }.onDelete(perform: deleteWorkout)
            
        }.listStyle(PlainListStyle())
            .navigationTitle("Workouts")
            .navigationBarItems (
                trailing:
                    Button(action: {
                        isPresented = true
                    }) {
                        Image(systemName: "plus")
                    })
            .foregroundColor(.primary)
            .sheet(isPresented: $isPresented, onDismiss: {
                workoutListVM.getAllWorkouts()
            },  content: {
                AddWorkoutScreen()
            })
            .embedInNavigationView()
        
            .onAppear(perform: {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().separatorColor = .clear
                workoutListVM.getAllWorkouts()///auto updates list with new workout upon return to workout list screen
            })
    }
}


