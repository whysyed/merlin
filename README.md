# Merlin iOS App

## Overview
Merlin is a test iOS application built with SwiftUI that demonstrates modern iOS development practices. The app includes authentication flows, and a dynamic user interface with mesh gradient animations.

## Features

### Authentication Flow
- Splash screen with animated logo
- Login screen with email/password authentication
- Registration capability for new users
- Error handling and validation
- Secure token management (access and refresh tokens)

## Project Structure

### Core Components
- `MerlinApp.swift`: Main application entry point
- `ContentView.swift`: Root view controller managing navigation flow
- `MainView.swift`: Primary interface after authentication
- `LoginView.swift`: Authentication interface
- `RegisterView.swift`: User registration interface

### Data Management
- CoreData integration for persistent storage
- CloudKit capability for iCloud sync
- Secure token management for API authentication

## Technical Requirements

- iOS 18.2+
- macOS 15.2+
- Xcode 16.2+
- Swift 5.0
- Active Apple Developer account for CloudKit features

## Architecture

### Design Patterns
- MVVM architecture
- SwiftUI for UI components
- Combine for reactive programming
- Async/await for asynchronous operations

### Security
- Secure authentication flow
- Token-based API authentication
- CloudKit integration for secure data sync

## Note

This is a test application created for demonstration purposes. It showcases various iOS development capabilities but is not intended for production use.
