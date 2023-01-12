//
//  authenticatorApp.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/12.
//

import SwiftUI

@main
struct authenticatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
