//
//  ContentView.swift
//  Task11
//
//  Created by Mayur on 23/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FormViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter your name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter your email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                
                Button(action: {
                    viewModel.submitForm()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Submit")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                if let responseMessage = viewModel.responseMessage {
                    Text(responseMessage)
                        .foregroundColor(viewModel.isError ? .red : .green)
                        .padding()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Submit Form")
        }
    }
}


#Preview {
    ContentView()
}
