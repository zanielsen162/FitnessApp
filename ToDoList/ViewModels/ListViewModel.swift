//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/18/24.
//

import Foundation

class ListViewModel: ObservableObject {

    @Published var items:[ExerciseItem] = [
        ExerciseItem(id: "Pull ups", sets: 2, reps: [8, 9]),
        ExerciseItem(id: "Sit ups", sets: 5, reps: [8, 9, 12, 2, 1])
    ]

    func addItem(item: ExerciseItem){
      items.append(item)
   }
}
