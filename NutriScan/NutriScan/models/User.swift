//
//  User.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-17.
//

import Foundation

struct User: Identifiable,Codable {
    let id : String
    let fullname : String
    let email : String
    let height: String
    let weight: String
    let targetWeight : String
    let gender : String
    let age : String
    let activityLevel: String
    
    var initials : String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
    
}

extension User {
    // Computed property to convert height from String to Double
    var doubleHeight: Double? {
        return Double(height)
    }
    
    // Computed property to convert weight from String to Double
    var doubleWeight: Double? {
        return Double(weight)
    }
    
    // Computed property to convert age from String to Double
    var doubleAge: Double? {
        return Double(age)
    }
    
    // Computed property to convert targetWeight from String to Double
    var doubleTargetWeight: Double? {
        return Double(targetWeight)
    }
}

//extension User{
//    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Ted Lasso", email: "test@gmail.com", height: "175",weight: "70", targetWeight: "68", gender: "Mail")
//}

