//
//  Validation.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-31.
//

import Foundation

struct Validation{
    static func validateEmail(_ email: String) -> String {
        return email.isEmpty ? "Email can not be empty" : !isValidEmail(email) ? "Invalid email format" : ""
    }
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func validateFullName(_ fullname: String) -> String {
        return fullname.isEmpty ? "Full name can not be empty" : !isValidFullName(fullname) ? "Invalid name format" : ""
    }
    
    static func isValidFullName(_ name: String) -> Bool {
        let nameRegex = "^[a-zA-Z ]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
    static func validatePassword(_ password: String) -> String {
        return password.isEmpty ? "Password can not be empty" : !isValidPassword(password) ? "Invalid password format" : ""
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$&*]).{6,15}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    static func validateConfirmedPassword(_ password: String, _ confirmedPassword: String)  -> String {
        return confirmedPassword.isEmpty ? "Confirmed password can not be empty" : !isValidConfirmedPassword(password, confirmedPassword) ?"Passwords do not match" : ""
    }
    static func isValidConfirmedPassword(_ password: String, _ confirmedPassword: String) -> Bool {
        return password == confirmedPassword
    }

    static func validateWeight(_ weight: String) -> String {
        return weight.isEmpty ? "Weight can not be empty" : !isValidWeight(weight) ? "Inavalid Weight format" : ""
    }
    
    static func isValidWeight(_ weight: String) -> Bool {
        let nameRegex = "^[0-9]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: weight)
    }
    static func validateHeight(_ height: String) -> String {
        return height.isEmpty ? "Height can not be empty" : !isValidHeight(height) ? "Inavalid height format" : ""
    }
    
    static func isValidHeight(_ height: String) -> Bool {
        let nameRegex = "^[0-9]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: height)
    }
    
    static func validateEditPassword(_ password: String) -> String {
        return  !isValidPassword(password) ? "Invalid password format" : ""
    }
    
    static func validateEditConfirmedPassword(_ password: String, _ confirmedPassword: String)  -> String {
        return  !password.isEmpty && !isValidConfirmedPassword(password, confirmedPassword) ?"Passwords do not match" : ""
    }


}
