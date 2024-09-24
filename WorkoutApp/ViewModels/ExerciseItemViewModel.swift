//
//  ExerciseItemViewModel.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/21/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ExerciseItemViewModel: ObservableObject {
    init() {}
    
    func toggleIsDone(item: ExerciseItem) {
        let itemCopy = item
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("completed_workouts")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
