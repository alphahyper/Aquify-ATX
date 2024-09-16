//
//  NoUserWarningView.swift
//  loginpage
//
//  Created by Rohan Konda on 7/2/24.
//

import SwiftUI

struct NoUserWarningView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Sorry, you are a guest, you don't have a profile page and you can't access the settings page.")
                Text("If you would like, you can")
                
                //signupbutton
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label:{
                    HStack(spacing: 2){
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 20))
                }
                
                Text("or")
                
                //signupbutton
                NavigationLink{
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } label:{
                    HStack(spacing: 2){
                        Text("Log in")
                            .fontWeight(.bold)
                        Text(".")
                    }
                    .font(.system(size: 20))
                }
            }
        }
    }
}

#Preview {
    NoUserWarningView()
}
