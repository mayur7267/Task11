//
//  ApiService.swift
//  Task11
//
//  Created by Mayur on 23/04/25.
//

import Foundation

class ApiService {
    static let shared = ApiService()

    func submitForm(name: String, email: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        let parameters: [String: Any] = [
            "name": name,
            "email": email
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            
            completion(.success("Form submitted successfully!"))
        }.resume()
    }
}
