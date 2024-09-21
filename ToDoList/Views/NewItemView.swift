//
//  NewItemView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/10/24.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewModel()
    // Build Workout
    @StateObject var viewModelWorkout = ListViewModel()
    @Binding var newItemPresented: Bool
    
    @State private var showDate = false
    @State private var upDown = "chevron.down"
    @State private var showWorkoutList = false
    @State private var tempName: String = ""
    @State private var tempSets: String = ""
    @State private var tempReps: String = ""
    
    var body: some View {
        VStack {
            Text("Plan New Workout")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 100)
            
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Due Date
                Section {
                    VStack {
                        Toggle("Schedule Workout?", isOn: $showDate)
                        if showDate {
                            DatePicker("Select Date", selection: $viewModel.dueDate, in: Date()..., displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                        }
                    }
                }
                
                Section {
                    VStack {
                        Button {
                            showWorkoutList.toggle()
                        } label: {
                            HStack {
                                Text("Build Workout")
                                Spacer()
                                Image(systemName: upDown)
                            }
                        }
                        
                        if showWorkoutList {
                            List {
                                ForEach(viewModelWorkout.items) {_ in
                                    ForEach(viewModelWorkout.items) { item in
                                        HStack {
                                            Text(item.id)
                                            Spacer()
                                            Text("\(item.sets)")
                                        }
                                        .padding()
                                    }
                                }
                                
                            }
                            HStack {
                                TextField("Exercise", text: $tempName)
                                TextField("Sets", text: $tempSets)
//                                TextField("Reps", text: $tempReps)
                                Button {
                                    if !tempName.isEmpty && Int(tempSets) != nil {
                                        viewModelWorkout.addItem(item: ExerciseItem(id: tempName, sets: Int(tempSets) ?? 0))
                                    }
                                } label: {
                                    Image(systemName: "plus.app")
                                }
                            }
                        }
                    }
                }
                
                
                // Save Button
                TLButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            
            
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields and select a due date that is today or later"))
            }
        }
        .padding()
    }
}
//
//struct NewItemView_Previews: PreviewProvider {
//    @State static var newItemPresented = true
//    
//    static var previews: some View {
//        NewItemView(newItemPresented: $newItemPresented)
//    }
//}
