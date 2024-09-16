//
//  AuthViewModel.swift
//  loginpage
//
//  Created by Bill Mar on 6/20/24.
//

import Foundation

import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel : ObservableObject{
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser();
        }
    }
    func signIN(withEmail email: String, password: String) async throws{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print ("DEBUG FAIL SIGN IN")
        }
        
    }
    func CreateUser(withEmail email:String, password:String, fullname:String, water: Int, waterGoal: Int) async throws{
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            //user creation
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email, water: water, waterGoal: waterGoal)
            let encodedUser = try Firestore.Encoder().encode(user)
            //storing user in database
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser();
        } catch {
            print("DEBUG NO CREATE")
        }
        print("Create user")
    }
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG failed to sign out")
        }
    }
    func deleteAccount(){
        
    }
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid 
        else {return}
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument()
        else {return}
        
        self.currentUser = try? snapshot.data(as: User.self)
        
        
        print("current user is \(String(describing: self.currentUser))")
            
    }
    
    func userId() -> String {
        guard let uid = Auth.auth().currentUser?.uid
        else {return ""}
        
        return uid;
    }
    
    
    
    
}
