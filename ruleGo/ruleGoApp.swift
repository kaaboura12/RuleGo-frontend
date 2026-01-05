//
//  ruleGoApp.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

@main
struct ruleGoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
