//
//  TeslaChargingData.swift
//  Merlin
//
//  Created by syed on 1/13/25.
//


import SwiftUI

// MARK: - TeslaChargingData Model
struct TeslaChargingData: Decodable {
    let batteryLevel: Int
    // Add more fields if the API provides them, e.g. chargingState, etc.
}

// MARK: - TeslaViewModel
class TeslaViewModel: ObservableObject {
    @Published var batteryLevel: Int = 0
    
    // Example fetch function (uses async/await)
    func fetchTeslaData() async {
        guard let url = URL(string: "https://api.camyai.com/tesla") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let responseData = try JSONDecoder().decode(TeslaChargingData.self, from: data)
            
            // Update the batteryLevel on the main thread
            await MainActor.run {
                self.batteryLevel = responseData.batteryLevel
            }
        } catch {
            print("Error fetching Tesla data: \(error)")
        }
    }
}
