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
            collectionPath: "users/\(userId)/completed_workouts"
        )
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
    @State var workoutRunTime = 0
    @State var displayWorkoutRunTime = "00:00:00"
    @State var stopwatch: Timer? = nil
    @State var startTime: Int = 0  // Track when the stopwatch starts
    @State var accumulatedTime: Int = 0
    
    @State var selectedPreviewExercise: String? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("New Workout", text: $tempWorkoutName)
                    .font(.system(size: 40))
                    .bold()
                
                HStack {
                    Text("Time Elapsed:")
                        .font(.system(size: 20))
                    Text(displayWorkoutRunTime)
                        .font(.system(size: 20))
                    
                    Button {
                        playPause = (playPause == "play.circle") ? "pause.circle" : "play.circle"
                        toggleStopwatch()
                    } label: {
                        Image(systemName: playPause)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    // allow for the new exercise to be set up
                    newExercise()
                    // take the input for each exercise
                    inputSets()
                }
                .padding([.leading, .trailing], 10)
                
                // view and modify previously added exercises
                VStack {
                    ForEach($newWorkout.routine) { $item in
                        Button {
                            selectedPreviewExercise = (selectedPreviewExercise == item.id) ? nil : item.id
                        } label: {
                            HStack {
                                Text(item.id)
                                Spacer()
                                Text("\(item.sets) sets")
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
                                        
                                        TextField("Reps", value: $item.reps[setIndex], format: .number)
                                            .keyboardType(.numberPad)
                                            .frame(width: 80)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                        Spacer()
                                    }
                                    .padding([.leading, .trailing], 30)
                                    .padding([.top, .bottom], 5)
                                }
                                
                                HStack {
                                    Button {
                                        item.sets += 1
                                        item.weight.append(0)
                                        item.reps.append(0)
                                    } label: {
                                        HStack{
                                            Text("Add Set")
                                            Image(systemName: "plus.app")
                                        }
                                    }
                                    
                                    Text(" / ")
                                    
                                    Button {
                                        guard !item.weight.isEmpty else {
                                            return
                                        }
                                        item.sets -= 1
                                        item.weight.removeLast()
                                        item.reps.removeLast()
                                    } label: {
                                        HStack{
                                            Text("Remove Set")
                                            Image(systemName: "minus.square")
                                        }
                                    }
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                }
                .padding(.top, 3)
                
                // finish the workout by storing it in the database
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
                            "routine": routineData,
                            "runTime": displayWorkoutRunTime
                        ])
                    
                    newWorkout = Workout(initName: "")
                    workoutStarted = false
                    stopStopwatch()
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
    
    func startStopwatch() {
        if stopwatch == nil {
            startTime = accumulatedTime
            
            stopwatch = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                updateStopwatch()
            }
        }
    }
    
    func pauseStopwatch() {
        // Invalidate the current timer
        stopwatch?.invalidate()
        stopwatch = nil
    }
    
    func stopStopwatch() {
        stopwatch?.invalidate()
        stopwatch = nil
        startTime = 0
        accumulatedTime = 0
        displayWorkoutRunTime = "00:00:00"
        playPause = "play.circle"
    }
    
    // Update stopwatch method
    func updateStopwatch() {
        // Calculate the total elapsed time including the previously accumulated time
        accumulatedTime = accumulatedTime + 1
        
        // Format the elapsed time as hours, minutes, and seconds
        let hours = Int(accumulatedTime) / 3600
        let minutes = (Int(accumulatedTime) % 3600) / 60
        let seconds = Int(accumulatedTime) % 60

        // Update the displayed run time
        displayWorkoutRunTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func toggleStopwatch() {
        if stopwatch == nil {
            startStopwatch()  // Resume or start
        } else {
            pauseStopwatch()  // Pause
        }
    }
    
    @ViewBuilder
    func newExercise() -> some View {
        HStack {
            TextField("Exercise Name", text: $tempExercise)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            
            Text(String(tempSets))
            HStack(spacing: 0) {
                Button {
                    tempSets += 1
                    inWeight.append(0)
                    inReps.append(0)
                } label: {
                    Image(systemName: "plus.app")
                        .foregroundColor(.gray)
                }
                Button {
                    guard !inWeight.isEmpty else {
                        return
                    }
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
                if !workoutStarted {
                    workoutStarted = true
                    newWorkout = Workout(initName: "")
                    newWorkout.name = tempWorkoutName
                }
                newWorkout.routine.append(ExerciseItem(id: tempExercise, sets: tempSets, reps: tempReps, weight: tempWeight))
                inReps = []
                inWeight = []
                tempSets = 0
                tempExercise = ""
            } label: {
                Image(systemName: "text.insert")
            }
            .buttonStyle(.bordered)
            .tint(.purple)
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    func inputSets() -> some View {
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
}


#Preview {
    StartWorkoutView(userId: "3gBkVCZYxDdACmVZP1WKvnawrmw1")
}
