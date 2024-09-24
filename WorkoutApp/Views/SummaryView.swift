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
        VStack{
            Text("Previous Workouts")
                .font(.system(size: 30))
                .bold()
                .padding([.top], 10)
            
            List(userWorkouts) { item in
                Button {
                    
                } label: {
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.system(size: 20))
                            Text(item.formattedDate)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    SummaryView(userId: "3gBkVCZYxDdACmVZP1WKvnawrmw1")
}
