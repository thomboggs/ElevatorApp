//
//  Elev8rApp.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import SwiftUI

@main
struct Elev8rApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject private var activeElevator = ActiveElevator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(activeElevator)
        }
    }
}
