//
//  MainView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/20/24.
//

import SwiftUI

import SwiftData


struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in
            TabView {
                SummaryView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                StartWorkoutView()
                    .tabItem {
                        Label("Start Workout", systemImage: "play.circle.fill")
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

#Preview {
    MainView()
}
