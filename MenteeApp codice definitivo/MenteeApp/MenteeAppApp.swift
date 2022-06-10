//
//  MenteeApp.swift
//  Mentee
//
//  Created by Fabiana Falgiano on 22/11/21.
//

import SwiftUI
import CoreData

@main
struct Mentee: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            TabBar().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
