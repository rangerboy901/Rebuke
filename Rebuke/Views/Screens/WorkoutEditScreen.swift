//
//  WorkoutEditScreen.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import SwiftUI

struct WorkoutEditScreen: View {
    
    @StateObject private var workoutEditVM = WorkoutEditViewModel()
    @Environment(\.presentationMode) var presentationMode
    let workout: WorkoutViewModel
    @Binding var workoutData: Workout.Data
    @State private var newExercise = ""
    @State private var priority: String = "Strength"
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
    
    
    var body: some View {
        List{
            Section(header: Text("Workout Details")) {
                TextField((workout.title), text:$workoutData.title)
                
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(10)
                    .font(.system(size: 20, weight: .bold, design: .default))
                
                Section("WorkoutObjective 📝"){
                    TextField((workout.objective), text:$workoutData.objective)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(10)
                        .font(.system(size: 20, weight: .bold, design: .default))
                }
                Text("Workout Type:")
                Picker("Workout Type:", selection: $workoutData.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(.primary)
                
            }
        }//  #endOf LIST
        .navigationTitle(workout.title)
    }
    
}
