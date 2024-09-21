//
//  ContentView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/10/24.
//

import SwiftUI
import SwiftData


struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in
            TabView {
                ToDoListView(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                StartedWorkoutView()
                    .tabItem {
                        Label("New Workout", systemImage: "play.circle")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
