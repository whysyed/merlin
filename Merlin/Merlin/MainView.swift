//
//  MainView.swift
//  Merlin
//
//  Created by syed on 1/15/25.
//

import SwiftUI

// MARK: - MainView (Home Content View)
struct MainView: View {
    @StateObject private var teslaVM = TeslaViewModel()

    var body: some View {
        ZStack {
            // Background
            Color("AppBackground")
                .ignoresSafeArea()

            VStack(spacing: 16) {
                
                // MARK: - Top Section
                topSection
                
                // MARK: - Meeting Section
                meetingSection
                
                // MARK: - Quick Info (Map/Weather bar)
                quickInfoBar
                
                // MARK: - Tiles (Samantha & Flight Info)
                tilesSection
                
                Spacer()
                
                // MARK: - Bottom Assistant Button
                assistantButton
                    .padding(.bottom, 16)
            }
            .padding(.top, 20)
        }
        .onAppear {
            // Fetch Tesla info (async task)
            Task {
                await teslaVM.fetchTeslaData()
            }
        }
    }
    
    // MARK: - Subviews
    
    /// Top "Welcome" + Avatar + Tesla Charging
    private var topSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Welcome")
                    .font(.title3)
                    .foregroundColor(.white)
                
                Text("Kevin")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            VStack(spacing: 6) {
                // Profile photo
                Image("ProfilePlaceholder") // Replace with your actual image asset
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                
                // Tesla battery ring
                ZStack {
                    // Background circle (gray ring)
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(lineWidth: 5)
                        .foregroundColor(.gray.opacity(0.3))
                        .frame(width: 44, height: 44)
                    
                    // Charged portion
                    Circle()
                        .trim(from: 0, to: min(CGFloat(teslaVM.batteryLevel) / 100, 1.0))
                        .stroke(
                            Color.green,
                            style: StrokeStyle(lineWidth: 5, lineCap: .round)
                        )
                        .frame(width: 44, height: 44)
                        .rotationEffect(.degrees(-90))
                    
                    Text("\(teslaVM.batteryLevel)")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                }
                
                Text("Tesla Charging")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.horizontal, 16)
    }
    
    /// Meeting Info
    private var meetingSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("10:00 - 11:30 AM")
                .font(.headline)
                .foregroundColor(.white)
            Text("Meeting with Anna")
                .font(.subheadline)
                .foregroundColor(.white)
            Text("Caffe Trieste")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.horizontal, 16)
    }
    
    /// Quick Info Bar (Map time, search, weather)
    private var quickInfoBar: some View {
        HStack(spacing: 16) {
            // Travel time
            ZStack {
                Capsule()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 80, height: 36)
                Text("12 min")
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Search icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
            
            // Weather
            Text("68°F")
                .foregroundColor(.white)
            Text("Cloudy")
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.horizontal, 16)
    }
    
    /// Two tiles: Samantha & Flight Info
    private var tilesSection: some View {
        HStack(alignment: .top, spacing: 16) {
            // Samantha
            VStack(alignment: .leading, spacing: 8) {
                Text("Samantha")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Birthday Party Check")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("• Gift")
                    Text("• Music")
                    Text("• Restaurant")
                }
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
            
            // Flight Info
            VStack(alignment: .leading, spacing: 8) {
                Text("Flight booked")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                Text("A278-HY")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(alignment: .top, spacing: 16) {
                    VStack(spacing: 2) {
                        Text("LHR")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("11:20 AM\nLondon")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    VStack(spacing: 2) {
                        Text("JFK")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("2:05 PM\nNew York")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.top, 4)
                
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
        .padding(.horizontal, 16)
    }
    
    /// Bottom Assistant Button
    private var assistantButton: some View {
        HStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 56, height: 56)
                
                Image(systemName: "bolt.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            Spacer()
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the login flow by default
        ContentView()
            .previewDisplayName("Login Flow")

        // Preview the main content
        MainView()
            .background(Color.black) // Helps see spacing
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Main Screen")
    }
}
