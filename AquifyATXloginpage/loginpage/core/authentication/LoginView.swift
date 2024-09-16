//
//  loginview.swift
//  loginpage
//
//  Created by Bill Mar on 6/18/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                //image
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 224.0)
                    .padding(.vertical, 32)
                
                
                //form fields
                VStack (spacing: 24){
                    InputView(text: $email, 
                              title: "Email Address",
                              placeHolder: "name@example.com")
                        
                    InputView(text: $password, 
                              title: "Password",
                              placeHolder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                //signinbutton
                Button {
                    Task {
                        try await viewModel.signIN(withEmail: email, password: password)
                    }
                } label:{
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: 350, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 20)
                Spacer()
                //signupbutton
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label:{
                    HStack(spacing: 2){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                //guest button
                NavigationLink{
                    MapView()
                        .navigationBarBackButtonHidden(true)
                } label:{
                    HStack(spacing: 2){
                        Text("Continue as guest")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}
