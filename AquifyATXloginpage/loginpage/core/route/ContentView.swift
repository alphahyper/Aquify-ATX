//
//  ContentView.swift
//  loginpage
//
//  Created by Bill Mar on 6/18/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                MapView()
            }
        }
    }
}

#Preview {
    ContentView()
}
