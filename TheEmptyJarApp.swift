//
//  TheEmptyJarApp.swift
//  TheEmptyJar
//
//  Created by Jesse Anderson on 5/21/21.
//

import SwiftUI

@main
struct TheEmptyJarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
