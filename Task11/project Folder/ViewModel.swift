//
//  ViewModel.swift
//  Task11
//
//  Created by Mayur on 23/04/25.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var responseMessage: String?
    @Published var isError: Bool = false

    func submitForm() {
        guard !name.isEmpty, !email.isEmpty else {
            self.responseMessage = "Please fill in all fields."
            self.isError = true
            return
        }

        isLoading = true
        ApiService.shared.submitForm(name: name, email: email) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let message):
                    self?.responseMessage = message
                    self?.isError = false
                case .failure(let error):
                    self?.responseMessage = error.localizedDescription
                    self?.isError = true
                }
            }
        }
    }
}
