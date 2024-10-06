//
//  SummaryView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/20/24.
//

import SwiftUI
import FirebaseFirestore

struct SummaryView: View {
    @FirestoreQuery var userWorkouts: [Workout]
    var user: String = ""
    
    init(userId: String) {
        self._userWorkouts = FirestoreQuery(
            collectionPath: "users/\(userId)/completed_workouts")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Previous Workouts")
                    .font(.system(size: 40))
                    .bold()
                    .padding([.top], 20)
                
                List(userWorkouts.sorted(by: { $0.dateCreated > $1.dateCreated })) { item in
                    NavigationLink(destination: viewWorkoutDetails(currWorkout: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.system(size: 20))
                                Text("Time Elapsed: " + item.runTime)
                                    .font(.system(size: 10))
                                    .padding([.bottom], 2)
                                Text(item.formattedDate)
                                    .font(.system(size: 12))
                            }
                            Spacer()
                        }
                        .swipeActions {
                            Button("Delete") {
                                    let db = Firestore.firestore()
                                    db.collection("users")
                                        .document(user)
                                        .collection("completed_workouts")
                                        .document(item.id)
                                        .delete()
                                }
                        }
                        .tint(.red)
                    }
                }
                .buttonStyle(.bordered)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    @ViewBuilder
    func viewWorkoutDetails(currWorkout: Workout) -> some View {
        VStack {
            VStack {
                Text(currWorkout.name)
                    .font(.system(size: 30))
                    .bold()
                Text(currWorkout.formattedDate)
                    .font(.system(size: 20))
            }
            .padding()
            
            List(currWorkout.routine) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.id)
                        .bold()
                    ForEach(0..<exercise.sets, id: \.self) { index in
                        HStack {
                            Text(String(exercise.weight[index]) + " lbs x ")
                            Text(String(exercise.reps[index]))
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    SummaryView(userId: "3gBkVCZYxDdACmVZP1WKvnawrmw1")
}
