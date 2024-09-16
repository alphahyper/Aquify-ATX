//
//  AddWaterView.swift
//  loginpage
//
//  Created by Rohan Konda on 7/9/24.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

struct AddWaterView: View {
    
    let database = Firestore.firestore()
    @State private var waterDrank = "";
    @State private var waterGoal = "";
    @State private var resetAlertEnabled = false;
    @State private var waterShown = 0;
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("How much more water did you drink today?")) {
                        TextField("Add water you drank today", text: $waterDrank)
                            .keyboardType(.numberPad)
                            .onReceive(Just(waterDrank)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.waterDrank = filtered
                                }
                            }
                        Button {
                            Task {
                                if (waterDrank != "") {
                                    await updateWater(text: waterDrank)
                                    waterShown = await getWater()
                                } else {
                                    print("can't update water goal to database")
                                }
                            }
                        } label: {
                            Text("Update Water You Drank Today")
                                .tint(.blue)
                                .bold()
                        }
                    
//                        Task {
//                            await updateWater(text: "0")
//                        }
                        
                        Button {
                            resetAlertEnabled = true;
                        } label: {
                            Text("Reset Water You Drank Today")
                                .tint(.red)
                                .bold()
                        }
                        .alert("Are you sure?", isPresented: $resetAlertEnabled) {
                            Button("Yes, reset.") {
                                Task {
                                    await updateWater(text: "\(-1 * waterShown)")
                                    waterShown = await getWater()
                                }
                            }
                            Button("No, go back.", role: .cancel) {
                                
                            }
                        } message: {
                            Text("Resetting will set the water you drank today back to 0.")
                        }
                        
                        Text("You drank " + "\(waterShown)" + " ounces of water today so far.")
                            .onAppear {
                                Task {
                                    waterShown = await getWater()
                                }
                            }
                        

                        
                    }
                    Section(header: Text("How much water do you want to drink per day?")) {
                        TextField("Water goal", text: $waterGoal)
                            .keyboardType(.numberPad)
                            .onReceive(Just(waterGoal)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.waterGoal = filtered
                                }
                            }
                        
                        Button {
                            Task {
                                if (waterGoal != "") {
                                    await updateWaterGoal(text: waterGoal)
                                } else {
                                    print("can't update water goal to database")
                                }
                            }
                        } label: {
                            Text("Update Water Goal")
                                .tint(.blue)
                                .bold()
                        }
                    }
                    Text("Press the blue or red buttons to update the new information, so that it will be displayed on the app. It is like clicking 'save'.")
                }
            }
        }
        .navigationTitle("Update Water Info")
        
    }
    func updateWater(text: String) async {
        let docRef = database.document("users/"+(Auth.auth().currentUser?.uid ?? ""))
        let newWater = await getWater() + (Int(text) ?? 0)
//        var data: Dictionary<String, Any>
//        docRef.getDocument { snapshot, error in
//            data = snapshot?.data() ?? [:]
//        }
        do { try await docRef.setData([
            "email": Auth.auth().currentUser?.email ?? "",
            "fullname": await getName(),
            "id": Auth.auth().currentUser?.uid ?? "",
            "water": newWater,
            "waterGoal": await getWaterGoal()])
        }
        catch {
            print("oh no")
        }
    }
    
    func updateWaterGoal(text: String) async {
        let docRef = database.document("users/"+(Auth.auth().currentUser?.uid ?? ""))
//        var data: Dictionary<String, Any>
//        docRef.getDocument { snapshot, error in
//            data = snapshot?.data() ?? [:]
//        }
        do { try await docRef.setData([
            "email": Auth.auth().currentUser?.email ?? "",
            "fullname": await getName(),
            "id": Auth.auth().currentUser?.uid ?? "",
            "water": await getWater(),
            "waterGoal": Int(text) ?? 0])
        }
        catch {
            print("oh no")
        }
    }
    
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
    
    func getNameHelper() async -> String? {
        let docRef = database.document("users/"+((Auth.auth().currentUser?.uid ?? "")))
        
        return await withCheckedContinuation { continuation in
            docRef.getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    continuation.resume(returning: "")
                    return
                }
                let text = data["fullname"] as? String
                continuation.resume(returning: text)
            }
        }
    }

    func getName() async -> String {
        if let water = await getNameHelper() {
            return water
        } else {
            return ""
        }
    }
}

#Preview {
    AddWaterView()
}
