//
//  StartWorkoutView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/20/24.
//

import SwiftUI

struct StartWorkoutView: View {
    var body: some View {
        VStack{
            Text("New Workout")
                .font(.system(size: 40))
                .bold()
            HStack {
                Text("Time Elapased:")
                    .font(.system(size: 20))
                Text("00:00:00")
                    .font(.system(size: 20))
            }
            
            
            VStack{
                Button {
                    VStack {
                        TextField("Name:", )
                    }
                } label: {
                    HStack{
                        Text("New Exercise")
                        Spacer()
                        Image(systemName: "plus.app")
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
        }
        .padding()
        Spacer()
    }
}

#Preview {
    StartWorkoutView()
}
