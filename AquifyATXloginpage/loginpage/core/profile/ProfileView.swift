//
//  ProfileView.swift
//  loginpage
//
//  Created by Bill Mar on 6/19/24.
//

import SwiftUI
import UIKit
import FirebaseFirestore
import FirebaseAuth

struct ProfileView: View {
    let database = Firestore.firestore()
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var waterValue: Int = 0
    @State private var waterGoalValue: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("You drank")
                
                Text("\(waterValue)")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                Text("ounces of water today!")
                
                    
                    
                
                    Text("-")
                    .opacity(0.0)
                    Text("-")
                    .opacity(0.0)
                HStack {
                    if (waterValue < waterGoalValue) {
                        Text("You have to drink")
                            .font(.system(size: 15))
                            .italic()
                            .foregroundColor(.gray)
                        Text("\(waterGoalValue - waterValue)")
                            .font(.system(size: 15))
                            .italic()
                            .bold()
                            .foregroundColor(.gray)
                        Text("ounces to reach your goal.")
                            .font(.system(size: 15))
                            .italic()
                            .foregroundColor(.gray)
                    } else {
                        Text("You met your goal today! Good job!")
                            .font(.system(size: 15))
                            .italic()
                            .bold()
                            .foregroundColor(.gray)
                    }
                }
                
                NavigationLink {
                    AddWaterView()
                } label: {
                    Text("Update water")
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .onAppear {
                    Task {
                        waterValue = await getWater()
                        waterGoalValue = await getWaterGoal()
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
//    func updateWater(text: String) {
//        let docRef = database.document("users/"+(Auth.auth().currentUser?.uid ?? ""))
//        docRef.setData(["water": text])
//    }
    
    func getWaterHelper() async -> Int? {
        let docRef = database.document("users/"+((Auth.auth().currentUser?.uid ?? "")))
        
        return await withCheckedContinuation { continuation in
            docRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    continuation.resume(returning: nil)
                    return
                }
                let text = data["water"] as? Int
                continuation.resume(returning: text)
            }
        }
    }

    func getWater() async -> Int {
        if let water = await getWaterHelper() {
            return water
        } else {
            return 0
        }
    }
    
    func getWaterGoalHelper() async -> Int? {
        let docRef = database.document("users/"+((Auth.auth().currentUser?.uid ?? "")))
        
        return await withCheckedContinuation { continuation in
            docRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    continuation.resume(returning: nil)
                    return
                }
                let text = data["waterGoal"] as? Int
                continuation.resume(returning: text)
            }
        }
    }

    func getWaterGoal() async -> Int {
        if let water = await getWaterGoalHelper() {
            return water
        } else {
            return 0
        }
    }
}
    
    struct ProfileView_Previews: PreviewProvider{
        static var previews: some View{
            ProfileView()
        }
    }
