//
//  LoginView.swift
//  Merlin
//
//  Created by syed on 1/15/25.
//

import SwiftUI

// MARK: - LoginView
struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var accessToken: String?
    @Binding var refreshToken: String?

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                MeshGradientBackground()
                    .zIndex(0)

                VStack(spacing: 24) {
                    // Title
                    Text("Welcome to Merlin")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    // Input Fields
                    VStack(spacing: 12) {
                        TextField("Email", text: $email)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6) // Reduce height
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(30)
                            .padding(.horizontal, 40)

                        SecureField("Password", text: $password)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 6) // Reduce height
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(30)
                            .padding(.horizontal, 40)
                    }

                    // Error Message
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }

                    // Login Button
                    Button(action: {
                        Task {
                            await performLogin()
                        }
                    }) {
                        Text("Login")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10) // Reduce height
                            .foregroundColor(.blue)
                            .background(Color.white)
                            .cornerRadius(30)
                            .padding(.horizontal, 40)
                    }

                    // Register and Forgot Password Buttons
                    HStack(spacing: 16) {
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8) // Reduce height
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.9))
                                .cornerRadius(30)
                        }

                        Button(action: {
                            // Handle forgot password action
                        }) {
                            Text("Forgot?")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8) // Reduce height
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.9))
                                .cornerRadius(30)
                        }
                    }
                    .frame(maxWidth: .infinity) // Match the Login button width
                    .padding(.horizontal, 40) // Align with Login button
                }
                .padding()
                .frame(maxWidth: 400)
                .zIndex(2)
            }
        }
    }

    // MARK: - Perform Login
    func performLogin() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }

        let loginURL = URL(string: "https://api.camyai.com/login")!
        var request = URLRequest(url: loginURL)
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

            if httpResponse.statusCode == 200 {
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                   let jsonDict = jsonObject as? [String: Any],
                   let access = jsonDict["accessToken"] as? String,
                   let refresh = jsonDict["refreshToken"] as? String
                {
                    accessToken = access
                    refreshToken = refresh
                    isLoggedIn = true
                } else {
                    errorMessage = "Unable to parse tokens."
                }
            } else {
                let serverError = String(data: data, encoding: .utf8) ?? "Unknown error"
                errorMessage = "Login failed: \(serverError)"
            }
        } catch {
            errorMessage = "Unable to connect to server. Please try again."
        }
    }
}
