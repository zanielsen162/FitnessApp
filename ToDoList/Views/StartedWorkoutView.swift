//
//  StartedWorkout.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/20/24.
//

import SwiftUI
import FirebaseFirestore

struct StartedWorkoutView: View {
    @StateObject var viewModel: StartedWorkoutViewModel
    @FirestoreQuery var items: [ExerciseItem]
        
    init(userId: String) {
        // users/<id>/todos/<entries>
        // underscore is convention for property wrappers
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(
            wrappedValue: StartedWorkoutViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    StartedWorkoutView(item: item.id)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    // Action
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

#Preview {
    StartedWorkoutView()
}
