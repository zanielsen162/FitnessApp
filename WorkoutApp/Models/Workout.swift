//
//  Workout.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct Workout: Codable, Identifiable {
    var id: String
    var name: String
    var routine: [ExerciseItem]
    var dateCreated: Date
    var runTime: String
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Set the style for the date (e.g., Jan 1, 2024)
        return formatter.string(from: dateCreated)
    }
    
    // Main initializer
    init(id: String, name: String, dateCreated: Date, routine: [ExerciseItem], runTime: String) {
        self.id = id
        self.dateCreated = dateCreated
        self.name = name
        self.routine = routine
        self.runTime = runTime
        
    }
    
    // Overloaded initializer
    init(initName: String) {
        self.id = UUID().uuidString // Generate a unique ID
        self.name = initName
        self.dateCreated = Date() // Set current date
        self.routine = [] // Initialize empty routine
        self.runTime = "00:00:00"
    }

    // Method to add an exercise
    func addExercise(item: ExerciseItem) {
        let itemCopy = item
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        guard !itemCopy.id.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("completed_workouts")
            .document(id)
            .collection("exercises")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
