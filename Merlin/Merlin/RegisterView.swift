//
//  RegisterView.swift
//  Merlin
//
//  Created by syed on 1/15/25.
//


import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var successMessage = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Register")
                .font(.largeTitle)
                .foregroundColor(.blue)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            if !successMessage.isEmpty {
                Text(successMessage)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            Button("Register") {
                Task {
                    await performRegister()
                }
            }
            .font(.headline)
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(12)

            Spacer()
        }
        .padding()
    }

    // MARK: - Perform Register
    func performRegister() async {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        let registerURL = URL(string: "https://api.camyai.com/register")!
        var request = URLRequest(url: registerURL)
        request.httpMethod = "POST"

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                errorMessage = "Unexpected response from server."
                return
            }

            if httpResponse.statusCode == 201 {
                successMessage = "Registration successful! You can now log in."
            } else {
                let serverError = String(data: data, encoding: .utf8) ?? "Unknown error"
                errorMessage = "Registration failed: \(serverError)"
            }
        } catch {
            errorMessage = "Unable to connect to server. Please try again."
        }
    }
}
