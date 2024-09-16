//
//  User.swift
//  loginpage
//
//  Created by Bill Mar on 6/20/24.
//

import Foundation
struct User: Identifiable, Codable{
    let id: String
    let fullname: String
    let email: String
    let water: Int //how much the user drank
    let waterGoal: Int //the goal of the water drank
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Kobe Bryant", email: "test@gmail.com", water: 0, waterGoal: 100)
}
