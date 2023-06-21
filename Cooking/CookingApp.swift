//
//  CookingApp.swift
//  Cooking
//
//  Created by apprenant70 on 22/06/2022.
//

import SwiftUI

@main
struct CookingApp: App {
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
