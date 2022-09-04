//
//  WorkoutListView.swift
//  Rebuke
//
//  Created by Joseph William DeWeese on 8/24/22.
//

import SwiftUI

struct WorkoutListView: View {
    
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
        List {
            
            ForEach(workoutListVM.workouts, id: \.workoutId) { workout in
                NavigationLink(
                    destination: WorkoutDetailView( workout: workout),
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
                        AddWorkoutView()
                    })
                    .embedInNavigationView()
                    
                    .onAppear(perform: {
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().separatorColor = .clear
                        workoutListVM.getAllWorkouts()
                    })
                
            }
                                 }
    

struct WorkoutCell: View {
    
    let workout: WorkoutViewModel
    func colorize(type: String) -> Color {
        switch type {
        case "HIIT":
            return .blue
        case "Recover":
            return .indigo
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
    
    var body: some View {
        
        VStack (alignment:.leading){
            HStack {
                Circle()
                    .frame(width: 15, height: 15, alignment: .center)
                    .foregroundColor(self.colorize(type: workout.type ))
                Text(workout.title)
                    .fontWeight(.semibold)
                    .accessibilityAddTraits(.isHeader)
                    .foregroundColor(.primary)
            }
            Text(workout.objective)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(self.colorize(type: workout.type ))
                .accessibilityLabel("\(workout.objective)Workout Description")
            
            HStack{
                Spacer()
                Text("\(workout.type)")
                    .foregroundColor(Color.primary)
                    .accessibilityLabel("\(workout.type) Workout type")
                    .font(.caption2)
                    .padding(3)
                    .overlay(
                        Capsule().stroke(self.colorize(type: workout.type ), lineWidth: 3.0)
                    )}
            .padding(.trailing, 15)
            
            .cornerRadius(10)
            
        }
        .padding(.all, 15)
        .overlay(
            RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: workout.type ), lineWidth: 5.0)
        )
    }
}
           
        
    

          
