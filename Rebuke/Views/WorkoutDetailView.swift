//
//  WorkoutDetailView.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import SwiftUI

struct WorkoutDetailView: View {
    //JWD:  PROPERTIES
    @StateObject private var workoutListVM = WorkoutListViewModel()
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let workout: WorkoutViewModel
    
    //JWD:  WORKOUT TYPES
    let types = ["HIIT", "Cardio", "Strength", "Power"]
    
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
    
    //THEMES
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    
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
                        Section(header: Text("Workout Details")) {
                            
                                Text("\(workout.title)")
                                
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .background(Color(UIColor.tertiarySystemFill))
                                    .cornerRadius(10)
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                    .foregroundColor(self.colorize(type: workout.type ))
                            }
                                Text("\(workout.objective)")
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .background(Color(UIColor.tertiarySystemFill))
                                    .cornerRadius(10)
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                    .foregroundColor(self.colorize(type: workout.type ))
                                    .accessibilityLabel("\(workout.objective)Workout Description")
                            }
                            
                                Text("\(workout.type) Type Workout.")
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .background(Color(UIColor.tertiarySystemFill))
                                    .cornerRadius(10)
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                    .foregroundColor(self.colorize(type: workout.type ))
                                    .accessibilityLabel("\(workout.type) Workout type")
                            }
                            
                        }//: #endOf Section
                        .navigationTitle("Workout Details")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing: Button("Edit") {
                            isPresented = true
                            //  data = workout.data
                        })
                        .navigationTitle(workout.title)
                        .fullScreenCover(isPresented: $isPresented) {
                            NavigationView {
                                WorkoutEditView(workout: workout)
                                    .navigationTitle(workout.title)
                                    .navigationBarItems(leading: Button("Cancel") {
                                        isPresented = false
                                        
                                    })
                            }
                        }
                    }
                 
                }
    
