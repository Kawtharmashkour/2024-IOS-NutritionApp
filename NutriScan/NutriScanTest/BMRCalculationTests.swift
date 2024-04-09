//
//  BMRCalculationTests.swift
//  NutriScanTest
//
//  Created by behnaz Khalili on 2024-04-07.
//

import XCTest
@testable import NutriScan

class BMRCalculationTests: XCTestCase {

    func testBMRMale() {
        let bmr = Sugestion.BMR(weight: 70, height: 175, age: 25, gender: "Male")
        XCTAssertEqual(bmr, 1673.75, accuracy: 0.1, "BMR calculation for male is incorrect")
    }

    func testBMRFemale() {
        let bmr = Sugestion.BMR(weight: 60, height: 160, age: 30, gender: "Female")
        XCTAssertEqual(bmr, 1289, accuracy: 0.1, "BMR calculation for female is incorrect")
    }

        func testTDEESedentary() {
            let tdee = Sugestion.TDEE(bmr: 1500, activityLevel: "Sedentary")
            XCTAssertEqual(tdee!, 1800, accuracy: 0.1, "TDEE calculation for sedentary activity level is incorrect")
        }

        func testTDEEHigh() {
            let tdee = Sugestion.TDEE(bmr: 1500, activityLevel: "High")
            XCTAssertEqual(tdee!, 2587.5, accuracy: 0.1, "TDEE calculation for high activity level is incorrect")
        }

        func testTDEEUnknownActivityLevel() {
            let tdee = Sugestion.TDEE(bmr: 1500, activityLevel: "Unknown")
            XCTAssertNil(tdee, "TDEE should be nil for unknown activity level")
        }

        func testBMICalculatorMaleNormalWeight() {
            let result = Sugestion.BMICalculator(weight: 75, height: 180, gender: "Male")
            XCTAssertEqual(result.0, 23.1, accuracy: 0.1, "BMI calculation is incorrect")
            XCTAssertEqual(result.1, "Normal weight (Male)", "BMI category is incorrect")
        }

        func testBMICalculatorFemaleObese() {
            let result = Sugestion.BMICalculator(weight: 75, height: 160, gender: "Female")
            XCTAssertEqual(result.0, 29.3, accuracy: 0.1, "BMI calculation is incorrect")
            XCTAssertEqual(result.1, "Obese (Female)", "BMI category is incorrect")
        }

        func testBMICalculatorUnknownGender() {
            let result = Sugestion.BMICalculator(weight: 70, height: 170, gender: "Other")
            XCTAssertEqual(result.0, 24.2, accuracy: 0.1, "BMI calculation is incorrect")
            XCTAssertEqual(result.1, "Unknown gender", "BMI category is incorrect")
        }


        func testWeightSugestionOverweight() {
            let suggestion = Sugestion.weightSugestion(idealBMI: 22, weight: 80, height: 170)
            XCTAssertEqual(suggestion, "You have 16.42 kg overweight", "Weight suggestion for overweight is incorrect")
        }

}
