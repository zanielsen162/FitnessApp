//
//  StartWorkoutView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/20/24.
//

import SwiftUI
import FirebaseFirestore

struct StartWorkoutView: View {
    @FirestoreQuery var exercises: [Workout]
    var userId: String
    
    init(userId: String) {
        self.userId = userId
        self._exercises = FirestoreQuery(
            collectionPath: "users/\(userId)/completed_workouts")
    }

    @State var workoutStarted: Bool = false
    @State var newWorkout: Workout = Workout(initName: "")
    @State var tempWorkoutName: String = "New Workout"
    
    @State var tempExercise: String = ""
    @State var tempSets: Int = 0
    @State var tempReps: [Double] = []
    @State var tempWeight: [Double] = []
    
    @State var inWeight: [Double] = []
    @State var inReps: [Double] = []
    
    @State var showNew: Bool = false
    @State var playPause = "play.circle"
    
    @State var selectedPreviewExercise: String? = nil
    
    var body: some View {
        ScrollView {
            VStack{
                TextField("New Workout", text: $tempWorkoutName)
                    .font(.system(size: 40))
                    .bold()
                HStack {
                    Text("Time Elapsed:")
                        .font(.system(size: 20))
                    Text("00:00:00")
                        .font(.system(size: 20))
                    Button {
                        playPause = (playPause == "play.circle") ? "pause.circle" : "play.circle"
                    } label: {
                        Image(systemName: playPause)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
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
                                    tempReps = inReps
                                    tempWeight = inWeight
                                    
                                    // Create new workout to save exercise to
                                    if !workoutStarted {
                                        workoutStarted = true
                                        newWorkout = Workout(initName: "")
                                        newWorkout.name = tempWorkoutName
                                    }
                                    
                                    // add the exercise to the current workout
                                    newWorkout.routine.append(ExerciseItem(id: tempExercise, sets: tempSets, reps: tempReps, weight: tempWeight))
                                    
                                    // reset
                                    inReps = []
                                    inWeight = []
                                    tempSets = 0
                                    tempExercise = ""
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
                
                VStack {
                    ForEach($newWorkout.routine) { $item in
                        Button {
                            selectedPreviewExercise = (selectedPreviewExercise == item.id) ? nil : item.id
                        } label: {
                            HStack {
                                Text(item.id)
                                Spacer()
                                Text(String(item.sets) + " sets")
                            }
                        }
                        .padding([.leading, .trailing], 30)
                        .padding([.top, .bottom], 1)
                        .buttonStyle(.bordered)
                        .foregroundColor(.black)
                        
                        if selectedPreviewExercise == item.id {
                            VStack {
                                ForEach(0..<item.sets, id: \.self) { setIndex in
                                    HStack {
                                        Spacer()
                                        TextField("Weight", value: $item.weight[setIndex], format: .number)
                                        .keyboardType(.decimalPad)
                                        .frame(width: 80)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        
                                        Text("lbs x")
                                        
                                        // Editable TextField for reps
                                        TextField("Reps", value: $item.reps[setIndex], format: .number)
                                            .keyboardType(.numberPad)
                                            .frame(width: 80)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        Spacer()
                                    }
                                    .padding([.leading, .trailing], 30)
                                    .padding([.top, .bottom], 5)
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                }
                .padding(.top, 3)
                
                
                Button {
                    newWorkout.name = tempWorkoutName
                    let db = Firestore.firestore()
                    let routineData = newWorkout.routine.map { $0.toDictionary() }
                    
                    db.collection("users")
                        .document(userId)
                        .collection("completed_workouts")
                        .document(newWorkout.id)
                        .setData([
                            "id": newWorkout.id,
                            "name": newWorkout.name,
                            "dateCreated": newWorkout.dateCreated,
                            "routine": routineData
                        ])

                    newWorkout = Workout(initName: "")
                    workoutStarted = false
                } label: {
                    Text("Finish Workout")
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                
                
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    StartWorkoutView(userId: "3gBkVCZYxDdACmVZP1WKvnawrmw1")
}
