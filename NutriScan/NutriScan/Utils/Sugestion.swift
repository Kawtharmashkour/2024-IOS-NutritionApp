//
//  BMRCalcilation.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-04-06.
// Giving Suggestion to user a bout their allowed calories daily

import Foundation

struct Sugestion {
    
    //BMR calculation
    static func BMR(weight : Double, height: Double, age: Double, gender: String) -> Double{
        var bmr = 0.0
        if gender == "Male" {
            bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5
        }
        
        else if gender == "Female" {
             bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161
        }
        
       return bmr
    }
    
    
    // TDEE calculatin
    enum ActivityLevel: String {
        case sedentary = "Sedentary"
        case light = "Light"
        case moderate = "Moderate"
        case high = "High"
        case extreme = "Extreme"
        
        var activityFactor: Double {
            switch self {
            case .sedentary: return 1.2
            case .light: return 1.375
            case .moderate: return 1.55
            case .high: return 1.725
            case .extreme: return 1.9
            }
        }
    }
    
    static func TDEE(bmr: Double, activityLevel: String) -> Double? {
        guard let activityLevel = ActivityLevel(rawValue: activityLevel) else {
            // If the activity level string doesn't match any enum case, return nil
            return nil
        }
        
        let activityFactor = activityLevel.activityFactor
        return bmr * activityFactor
    }
    
    
    //BMI calculation
   static func BMICalculator(weight: Double, height: Double, gender: String) -> (Double, String) {
        let heightInMeters = height / 100
        let BMI = weight / pow(heightInMeters, 2)
        let roundedBMI = round(BMI * 10) / 10
        
        var message = ""
        
        if gender == "Male" {
            if roundedBMI < 20 {
                message = "Underweight (Male)"
            } else if roundedBMI >= 20 && roundedBMI < 25 {
                message = "Normal weight (Male)"
            } else if roundedBMI >= 25 && roundedBMI < 30 {
                message = "Overweight (Male)"
            } else {
                message = "Obese (Male)"
            }
        } else if gender == "Female" {
            if roundedBMI < 19 {
                message = "Underweight (Female)"
            } else if roundedBMI >= 19 && roundedBMI < 24 {
                message = "Normal weight (Female)"
            } else if roundedBMI >= 24 && roundedBMI < 29 {
                message = "Overweight (Female)"
            } else {
                message = "Obese (Female)"
            }
        } else {
            // Handle unknown gender
            message = "Unknown gender"
        }
        
        return (roundedBMI, message)
    }
    
   static func weightSugestion (idealBMI: Double, weight: Double, height: Double) -> String? {
       
       var message = ""
        let idealWeight = idealBMI * pow(height / 100, 2) // Calculate ideal weight using ideal BMI and height
        if (idealWeight > weight) {
            let underWeight =  idealWeight - weight
            ("You have \(String(format: "%.2f", underWeight)) kg underweight")
        }
        if (idealWeight <=  weight) {
            let overWeight = weight - idealWeight
            message = ("You have \(String(format: "%.2f", overWeight)) kg overweight")
        }
       return message
    }

}
