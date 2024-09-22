//
//  StartWorkoutView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/20/24.
//

import SwiftUI

struct StartWorkoutView: View {
    @State var tempExercise: String = ""
    @State var tempSets: Int = 0
    @State var tempReps: [Double] = []
    @State var tempWeight: [Double] = []
    
    @State var inWeight: [Double] = []
    @State var inReps: [Double] = []
    
    @State var showNew: Bool = false
    @State var playPause = "play.circle"
    
    var body: some View {
        VStack{
            Text("New Workout")
                .font(.system(size: 40))
                .bold()
            HStack {
                Text("Time Elapased:")
                    .font(.system(size: 20))
                Text("00:00:00")
                    .font(.system(size: 20))
                Button {
                    playPause = (playPause == "play.circle") ? "pause.circle" : "play.circle"
                } label: {
                    Image(systemName: playPause)
                }
            }
            
            
            VStack{
                Button {
                    showNew.toggle()
                } label: {
                    HStack{
                        Text("New Exercise")
                        Spacer()
                        Image(systemName: "plus.app")
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                
                if showNew {
                    VStack {
                        HStack{
                            TextField("Exercise Name", text: $tempExercise)
                            Spacer()
                            
                            Text(String(tempSets))
                            HStack(spacing: 0){
                                Button {
                                    tempSets += 1
                                    inWeight.append(0)
                                    inReps.append(0)
                                } label: {
                                    Image(systemName: "plus.app")
                                        .foregroundColor(.gray)
                                }
                                Button {
                                    inWeight.removeLast()
                                    inReps.removeLast()
                                    tempSets = max(tempSets - 1, 0)
                                } label: {
                                    Image(systemName: "minus.square")
                                        .foregroundColor(.gray)
                                }
                            }
                            Button {
                                tempSets = 0
                                tempExercise = ""
                                tempReps = inReps
                                tempWeight = inWeight
                                inReps = []
                                inWeight = []
                                // NEED TO INPUT PROCEDURE FOR SAVING TO DATABASE
                            } label: {
                                Image(systemName:"text.insert")
                            }
                            .buttonStyle(.bordered)
                            .tint(.purple)
                        }
                        
                        ForEach(0..<tempSets, id: \.self) { index in
                            HStack {
                                TextField("Weight", value: $inWeight[index], format: .number)
                                    .keyboardType(.numberPad)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Text("lbs")
                                TextField("Reps", value: $inReps[index], format: .number)
                                    .keyboardType(.numberPad)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                    .padding([.leading, .trailing], 30)
                    
                }
            }
            
            
        }
        .padding()
        Spacer()
    }
}

#Preview {
    StartWorkoutView()
}
