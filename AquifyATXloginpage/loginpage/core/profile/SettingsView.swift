//
//  ProfileView.swift
//  loginpage
//
//  Created by Bill Mar on 6/19/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser {
            VStack {
                List {
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray))
                                .clipShape(Circle())
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                    Section("General"){
                        HStack{
                            SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                            Spacer()
                            
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Section("Account"){
                            Button{
                                viewModel.signOut()
                            } label:{
                                SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                            }
                            Button{
                                print("Delete Account")
                            } label:{
                                SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: Color(.red))
                            }
                        }
                    }
                    
                }
                
                HStack(spacing: 30) {
                    
                    /* profile link */
                    NavigationLink{
                        if (viewModel.userSession != nil) {
                            ProfileView()
                                .navigationBarBackButtonHidden(true)
                        }
                        else { NoUserWarningView()
                        }
                    } label:{
                        VStack(spacing: 4){
                            Image(systemName: "person.crop.circle")
                                .padding()
                                .scaledToFit()
                                .font(.system(size: 30))
                            Text("Profile")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                        }
                    }
                    
                    
                    /* map link */
                    NavigationLink{
                        MapView()
                            .navigationBarBackButtonHidden(true)
                    } label:{
                        VStack(spacing: 4){
                            Image(systemName: "map.fill")
                                .padding()
                                .scaledToFit()
                                .font(.system(size: 30))
                            Text("Map")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                        }
                    }
                    
                    
                    /* settings link */
                    NavigationLink{
                        if (viewModel.userSession != nil) {
                            SettingsView()
                                .navigationBarBackButtonHidden(true)
                        }
                        else { NoUserWarningView()
                        }
                    } label:{
                        VStack(spacing: 4){
                            Image(systemName: "gear")
                                .padding()
                                .scaledToFit()
                                .font(.system(size: 30))
                            Text("Settings")
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                        }
                    }
                }
            }
    }
    }
}
    
    struct SettingsView_Previews: PreviewProvider{
        static var previews: some View{
            SettingsView()
        }
    }
