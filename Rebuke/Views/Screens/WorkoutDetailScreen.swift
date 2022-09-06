//
//  WorkoutDetailView.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 9/4/22.
//

import SwiftUI

struct WorkoutDetailScreen: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject private var workoutDetailVM = WorkoutDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    let workout: WorkoutViewModel
    @State private var data = Workout.Data()
    @State private var isPresented: Bool = false
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
        
        VStack (alignment:.leading){
            List {
                
                Section(header: Text("Select to begin workout")){
                    NavigationLink(
                        destination:  TimerView()
                    ){
                        Label("Begin Workout", systemImage: "timer")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: workout.type ), lineWidth: 3.0)
                    )}
                
                VStack(alignment: .leading, spacing: 20) {
                    Section(header: Text("Workout Name:")) {
                        
                        Text(workout.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(10)
                            .font(.system(size: 18, weight: .semibold, design: .default))
                            .foregroundColor(.primary)
                        
                        Divider()
                    }
                    Section(header: Text("Workout Objective:")) {
                        Text(workout.objective)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(10)
                            .font(.system(size: 18, weight: .semibold, design: .default))
                            .foregroundColor(.primary)
                        Divider()
                    }
                    Section(header: Text("Workout Type:")) {
                        Text(workout.type)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .font(.system(size: 18, weight: .semibold, design: .default))
                            .foregroundColor(.primary)
                            .accessibilityLabel(workout.type)
                    }
                    .accessibilityElement(children: .ignore)
                }//: #endOf Section
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [self.colorize(type: workout.type ), Color(#colorLiteral(red: 0.9685427547, green: 0.9686816335, blue: 0.9685124755, alpha: 1))]), startPoint: .bottom, endPoint: .top))
                //.clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: workout.type ), lineWidth: 5.0)
                )
            }
            .listStyle(InsetGroupedListStyle())
            
        }
        
        .navigationTitle("Workout Details")
        .navigationBarItems(trailing: Button("Edit") {
            HapticManager.notification(type: .success)
            isPresented = true
        })
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                WorkoutEditScreen(workout: workout, workoutData: $data)
                    .navigationTitle(workout.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        HapticManager.notification(type: .success)
                        isPresented = false
                    }, trailing: Button("Save") {
                        HapticManager.notification(type: .success)
                        isPresented = false
                        do {
                            try managedObjectContext.save()
                            }catch {
                                print("Failed to save scrum: \(error.localizedDescription)")
                            }
                        })
                    }
            }
        }
    }

