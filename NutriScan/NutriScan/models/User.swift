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
    let weight: String
    let height: String
    let targetWeight : String
    let gender : String
    
    var initials : String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
    
}

extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Ted Lasso", email: "test@gmail.com", weight: "70", height: "175", targetWeight: "68", gender: "Mail")
}

