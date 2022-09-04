//
//  AddWorkoutView.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import SwiftUI

struct AddWorkoutView: View {
    
    @StateObject private var addWorkoutVM = AddWorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var color: Color = Color.clear
    @State private var newExercise = ""
    let types = ["Strength", "Power", "Cardio", "HIIT", "Recover"]
    
    
    
    var body: some View {
        Form{
            Section(header: Text("Workout Details")) {
                TextField("Enter workout name", text:
                            $addWorkoutVM.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(10)
                .font(.system(size: 20, weight: .bold, design: .default))
                TextField("Enter workout objective", text: $addWorkoutVM.objective)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(10)
                    .font(.system(size: 20, weight: .bold, design: .default))
                
                Text("Workout Type:")
                Picker("Workout Type:", selection: $addWorkoutVM.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Divider()
                
                    DatePicker("Release Date:", selection: $addWorkoutVM.releaseDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(10)
                        .font(.system(size: 17, weight: .semibold, design: .default))
                    
                    
                }
                HStack {
                    Spacer()
                    Button("Save"){
                        
                        addWorkoutVM.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                }
            }//  #endOf FORM
            .navigationBarTitle("Add Workout", displayMode: .inline)
        }
    }
    

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
