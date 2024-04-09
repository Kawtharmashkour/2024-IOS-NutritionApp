//
//  Sugestion.swift
//  NutriScanTests
//
//  Created by behnaz Khalili on 2024-04-07.
//

import XCTest


final class Sugestion: XCTestCase {

    func testSuccessfulWeightSuggestion(){
        func testBMICalculatorMaleUnderweight() {
             let result = BMICalculator(weight: 60, height: 180, gender: "Male")
             XCTAssertEqual(result.0, 18.5, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Underweight (Male)", "BMI category is incorrect")
         }

         func testBMICalculatorMaleNormalWeight() {
             let result = BMICalculator(weight: 75, height: 180, gender: "Male")
             XCTAssertEqual(result.0, 23.1, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Normal weight (Male)", "BMI category is incorrect")
         }

         func testBMICalculatorMaleOverweight() {
             let result = BMICalculator(weight: 85, height: 180, gender: "Male")
             XCTAssertEqual(result.0, 26.2, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Overweight (Male)", "BMI category is incorrect")
         }

         func testBMICalculatorMaleObese() {
             let result = BMICalculator(weight: 100, height: 180, gender: "Male")
             XCTAssertEqual(result.0, 30.9, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Obese (Male)", "BMI category is incorrect")
         }

         // Repeat similar tests for "Female" and unknown gender cases.
         
         func testBMICalculatorFemaleUnderweight() {
             let result = BMICalculator(weight: 50, height: 160, gender: "Female")
             XCTAssertEqual(result.0, 19.5, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Underweight (Female)", "BMI category is incorrect")
         }

         func testBMICalculatorFemaleNormalWeight() {
             let result = BMICalculator(weight: 55, height: 160, gender: "Female")
             XCTAssertEqual(result.0, 21.5, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Normal weight (Female)", "BMI category is incorrect")
         }

         func testBMICalculatorFemaleOverweight() {
             let result = BMICalculator(weight: 65, height: 160, gender: "Female")
             XCTAssertEqual(result.0, 25.4, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Overweight (Female)", "BMI category is incorrect")
         }

         func testBMICalculatorFemaleObese() {
             let result = BMICalculator(weight: 75, height: 160, gender: "Female")
             XCTAssertEqual(result.0, 29.3, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Obese (Female)", "BMI category is incorrect")
         }

         func testBMICalculatorUnknownGender() {
             let result = BMICalculator(weight: 70, height: 170, gender: "Other")
             XCTAssertEqual(result.0, 24.2, "BMI calculation is incorrect")
             XCTAssertEqual(result.1, "Unknown gender", "BMI category is incorrect")
         }
        
    }

}
