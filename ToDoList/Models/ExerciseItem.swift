//
//  ExerciseItem.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/18/24.
//

import Foundation

struct ExerciseItem: Codable, Identifiable {
    let id: String
    var sets: Int = 0
    var reps: [Int] = []
    
    mutating func setReps(_ set: Int, _ rep_completed: Int) {
        reps[set - 1] = rep_completed
    }
}
