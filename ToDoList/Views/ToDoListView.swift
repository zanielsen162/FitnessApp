//
//  ToDoListItemsView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/10/24.
//

import SwiftUI
import FirebaseFirestore

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewModel
    @FirestoreQuery var items: [ToDoListItem]
        
    init(userId: String) {
        // users/<id>/todos/<entries>
        // underscore is convention for property wrappers
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
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

//#Preview {
//    ToDoListView(userId: <#T##String#>)
//}
