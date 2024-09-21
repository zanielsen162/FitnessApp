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
    
    init(userId: String) {
        self.userId = userId
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
