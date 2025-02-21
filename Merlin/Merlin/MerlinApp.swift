//
//  MerlinApp.swift
//  Merlin
//
//  Created by syed on 1/13/25.
//

import SwiftUI

@main
struct MerlinApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
