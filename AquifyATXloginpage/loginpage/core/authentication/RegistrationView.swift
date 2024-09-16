//
//  RegistrationView.swift
//  loginpage
//
//  Created by Bill Mar on 6/19/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            //image
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 224.0)
                .padding(.vertical, 32)
            
            //form fields
            VStack (spacing: 12){
                InputView(text: $email,
                          title: "Email Address",
                          placeHolder: "name@example.com")
                
                InputView(text: $fullName,
                          title: "Full Name",
                          placeHolder: "Enter your name")
                
                InputView(text: $password,
                          title: "Password",
                          placeHolder: "Enter your password",
                          isSecureField: true)
                
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeHolder: "Confirm your password",
                          isSecureField: true)
                
                ZStack(alignment: .trailing) {
//                    InputView(text: $confirmPassword,
//                              title: "Confirm Password",
//                              placeHolder: "Confirm your password",
//                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))                        }
                    }
                    
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.CreateUser(withEmail: email, password: password, fullname: fullName, water: 0, waterGoal: 100)
                }
            } label:{
                HStack{
                    Text("SIGN UP")
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
            
            Button{
                dismiss()
            } label:{
                HStack(spacing: 2){
                    Text("Already have an account?")
                    Text("Sign in")
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

extension RegistrationView : AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}

#Preview {
    RegistrationView()
}
