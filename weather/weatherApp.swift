//
//  weatherApp.swift
//  weather
//
//  Created by Ancient on 06/05/21.
//

import SwiftUI

@main
struct weatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
