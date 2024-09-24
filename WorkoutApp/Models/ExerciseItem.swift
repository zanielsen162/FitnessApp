//
//  ExerciseItem.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/18/24.
//

import Foundation

struct ExerciseItem: Codable, Identifiable {
    let id: String
    var sets: Int
    var reps: [Double]
    var weight: [Double]
    
    mutating func setReps(_ set: Int, _ rep_completed: Double, _ weight_completed: Double) {
        reps[set - 1] = rep_completed
        weight[set - 1] = weight_completed
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "sets": sets,
            "reps": reps,
            "weight": weight
        ]
    }
    
    init(id: String, sets: Int, reps: [Double], weight: [Double]) {
        self.id = id
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
    
    init(id: String) {
        self.id = id
        self.sets = 0
        self.reps = []
        self.weight = []
    }
}
