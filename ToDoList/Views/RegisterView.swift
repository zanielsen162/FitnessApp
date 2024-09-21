//
//  RegisterView.swift
//  ToDoList
//
//  Created by Zoey Nielsen on 9/10/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            HeaderView(title: "Register", subtitle: "Start organizing todos", angle: -15, background: .orange)
        
            Form{
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TLButton(title: "Login", background: Color.green) {
                    // attempt registration
                    viewModel.register()
                }
                .padding()
            }
            .offset(y: -50)
            
        }
        Spacer()
    }
    
}

#Preview {
    RegisterView()
}
