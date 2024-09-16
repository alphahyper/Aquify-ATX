//
//  loginpageApp.swift
//  loginpage
//
//  Created by Bill Mar on 6/18/24.
//

import SwiftUI
import Firebase

@main
struct loginpageApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
