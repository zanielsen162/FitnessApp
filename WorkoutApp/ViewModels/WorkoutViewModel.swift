//
//  WorkoutViewModel.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/23/24.
//

import Foundation

import Foundation
import FirebaseAuth
import FirebaseFirestore

class WorkoutViewModel: ObservableObject {
    init() {}
    
    func addExercise(set: Workout, item: ExerciseItem) {
        var itemCopy = item
        var setCopy = set
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("completed_workouts/" + setCopy.id)
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
