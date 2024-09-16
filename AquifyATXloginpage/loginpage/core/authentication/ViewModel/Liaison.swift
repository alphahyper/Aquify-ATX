//
//  Liaison.swift
//  loginpage
//
//  Created by Rohan Konda on 7/8/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class Liaison: NSObject, ObservableObject {
//
   
    private var c: Int;
    
    override init() {
        c = 0;
    }
    
    @MainActor @objc func getWater() async -> Int  {
        guard let uid = Auth.auth().currentUser?.uid else {return 0}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()
            else {return 0}
        return snapshot.data()?["water"] as! Int
    }
}
