//
//  ContentView.swift
//  Merlin
//
//  Created by syed on 1/13/25.
//

import SwiftUI

// MARK: - Root ContentView with Splash/Login/Main Flow
struct ContentView: View {
    @State private var showSplash = true

    @State private var isLoggedIn = false
    @State private var accessToken: String?
    @State private var refreshToken: String?

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
            } else {
                if isLoggedIn {
                    MainView()
                } else {
                    LoginView(
                        isLoggedIn: $isLoggedIn,
                        accessToken: $accessToken,
                        refreshToken: $refreshToken
                    )
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}


// MARK: - SplashView
struct SplashView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer() // Push content to the center vertically
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer() // Ensure vertical centering
            }
        }
    }
}

// MARK: - Gradient
struct MeshGradientBackground: View {
    @State private var isAnimating = false
    @State private var currentIndex = 0
    static let primaryBlue = Color(red: 0.788235294117647, green: 0.8745098039215686, blue: 0.9019607843137255)
    static let primaryKhaki = Color(red: 0.9372549019607843, green: 0.9294117647058824, blue: 0.9019607843137255)
    static let primaryPink = Color(red: 0.9058823529411765, green: 0.8274509803921568, blue:0.8745098039215686)
    static let primaryPurple = Color(red: 0.8431372549019608, green: 0.6392156862745098, blue: 0.807843137254902)
    static let primaryCyan = Color(red: 0.5372549019607843, green: 0.7411764705882353, blue: 0.7294117647058823)
    
    static let primaryPeach = Color(red: 0.98, green: 0.86, blue: 0.76)
    static let primaryMint = Color(red: 0.78, green: 0.93, blue: 0.88)
    static let primaryLavender = Color(red: 0.89, green: 0.88, blue: 0.96)
    static let primaryLemon = Color(red: 0.99, green: 0.97, blue: 0.83)
    static let primarySky = Color(red: 0.75, green: 0.89, blue: 0.98)
    static let primaryCream = Color(red: 0.98, green: 0.94, blue: 0.90)
    static let primaryBlush = Color(red: 0.97, green: 0.80, blue: 0.83)
    static let primarySeafoam = Color(red: 0.71, green: 0.92, blue: 0.85)
    static let primarySand = Color(red: 0.94, green: 0.88, blue: 0.79)
    static let primaryIce = Color(red: 0.87, green: 0.96, blue: 0.98)

    
    let colorSets: [[Color]] = [
        [
            // State 1
            primaryKhaki, primaryKhaki, primaryKhaki,
            primaryPink, primaryPink, primaryBlue,
            primaryPink, primaryPink, primaryBlue
        ],
        [
            // State 2
            primaryKhaki, primaryBlue, primaryKhaki,
            primaryPink, primaryKhaki, primaryPurple,
            primaryPink, primaryKhaki, primaryPurple
        ],
        [
            // State 3
            primaryBlue, primaryBlue, primaryBlue,
            primaryCyan, primaryPink, primaryPurple,
            primaryCyan, primaryPink, primaryPurple
        ],
        [
            // State 4
            primaryPink, primaryPurple, primaryCyan,
            primaryCyan, primaryBlue, primaryKhaki,
            primaryCyan, primaryBlue, primaryKhaki
        ],
        [
            // State 5
            primaryPurple, primaryPink, primaryBlue,
            primaryCyan, primaryKhaki, primaryBlue,
            primaryCyan, primaryKhaki, primaryBlue
        ],
        //Additional
        [
            primaryPeach, primaryMint, primaryLavender,
            primaryLemon, primarySky, primaryCream,
            primaryBlush, primarySeafoam, primarySand
        ],
        [
            primaryLavender, primarySky, primaryMint,
            primaryBlush, primaryIce, primarySand,
            primaryCream, primaryPeach, primaryMint
        ],
        [
            primaryLemon, primaryBlush, primarySky,
            primaryMint, primaryIce, primaryPeach,
            primaryLavender, primarySand, primaryBlue
        ],
        [
            primarySeafoam, primaryMint, primaryLavender,
            primaryIce, primaryBlush, primaryCream,
            primaryKhaki, primaryPeach, primarySky
        ],
        [
            primaryPink, primarySky, primaryCream,
            primaryMint, primaryBlush, primaryLavender,
            primaryPeach, primaryIce, primarySeafoam
        ],
        [
            primaryCyan, primaryPeach, primaryLemon,
            primaryMint, primaryCream, primaryBlush,
            primarySky, primarySand, primaryIce
        ],
        [
            primaryLavender, primarySand, primaryPeach,
            primaryBlush, primaryIce, primaryMint,
            primaryKhaki, primaryCyan, primarySky
        ],
        [
            primaryLemon, primaryLavender, primaryPink,
            primaryMint, primaryPeach, primarySky,
            primaryCream, primarySand, primaryIce
        ],
        [
            primaryCream, primarySky, primarySand,
            primaryMint, primaryLemon, primaryLavender,
            primaryPeach, primaryBlush, primaryCyan
        ],
        [
            primarySeafoam, primaryIce, primaryCream,
            primaryBlush, primaryLavender, primaryPink,
            primaryCyan, primaryLemon, primaryKhaki
        ],
        [
            primaryPeach, primaryLavender, primarySand,
            primaryBlush, primarySky, primaryMint,
            primaryIce, primaryCream, primaryCyan
        ],
        [
            primaryMint, primaryLemon, primaryCream,
            primaryBlush, primaryIce, primaryLavender,
            primaryPeach, primarySand, primarySky
        ],
        [
            primaryLavender, primaryBlush, primaryPeach,
            primaryMint, primarySand, primaryIce,
            primaryLemon, primarySky, primarySeafoam
        ],
        [
            primaryPeach, primaryLavender, primaryCream,
            primarySand, primaryBlush, primaryMint,
            primarySky, primaryCyan, primaryLemon
        ],
        [
            primaryIce, primaryCream, primaryMint,
            primaryBlush, primarySky, primarySand,
            primaryPeach, primaryLavender, primaryLemon
        ]
    ]
    
    var body: some View {
        // A 3x3 mesh gradient
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                // Row 1 (top)
                .init(x: 0,   y: 0),
                .init(x: 0.5, y: 0),
                .init(x: 1,   y: 0),

                // Row 2 (middle)
                .init(x: 0,   y: 0.5),
                .init(x: 0.5, y: 0.5),
                .init(x: 1,   y: 0.5),

                // Row 3 (bottom)
                .init(x: 0,   y: 1),
                .init(x: 0.5, y: 1),
                .init(x: 1,   y: 1)
            ],
            colors: colorSets[currentIndex]
        )
        .ignoresSafeArea() // Fill entire screen
        .onAppear {
            // Animate back and forth between colors1 and colors2
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 2)) {
                    currentIndex = (currentIndex + 1) % colorSets.count
                }
            }
        }
    }
}

