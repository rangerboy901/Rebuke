//
//  WorkoutCell.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 9/5/22.
//

import SwiftUI

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
                    .foregroundColor(.black)
            }
            Text(workout.objective)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .accessibilityLabel("\(workout.objective)Workout Description")
            
            HStack{
                Spacer()
                Text("\(workout.type)")
                    .foregroundColor(.primary)
                    .accessibilityLabel("\(workout.type) Workout type")
                    .font(.caption2)
                    .padding(3)
                    .overlay(
                        Capsule().stroke(self.colorize(type: workout.type ), lineWidth: 3.0)
                    )}
            .padding(.trailing, 15)
            
            .cornerRadius(10)
            
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)),Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))]), startPoint: .bottom, endPoint: .top))
        .overlay(
            RoundedRectangle(cornerSize: .zero).stroke(self.colorize(type: workout.type ), lineWidth: 5.0))
    }
}
