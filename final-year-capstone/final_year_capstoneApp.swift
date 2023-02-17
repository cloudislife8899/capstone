//
//  final_year_capstoneApp.swift
//  final-year-capstone
//
//  Created by Michael Wang on 2023-02-16.
//

import SwiftUI

@main
struct final_year_capstoneApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
