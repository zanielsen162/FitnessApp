//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/10/24.
//

import SwiftUI
import FirebaseCore

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
