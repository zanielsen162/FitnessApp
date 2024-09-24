//
//  StartWorkoutViewModel.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/20/24.
//

import FirebaseFirestore
import Foundation

class StartWorkoutViewModel: ObservableObject {
    @Published var showingNewItemView = false
    
    private let userId: String
    private let workoutId: String
    
    init(userId: String, workoutId: String) {
        self.userId = userId
        self.workoutId = workoutId
    }
    
    func addWorkout(userId: String, workoutId: String, addMe: Workout) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("completed_workouts")
            .document(workoutId)
            .setData(addMe.asDictionary())
    }
    
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
