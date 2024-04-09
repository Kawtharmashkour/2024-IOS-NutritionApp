//
//  TextRecognitionUtilitiesTests.swift
//  NutriScanTest
//
//  Created by behnaz Khalili on 2024-04-09.
//

import XCTest
@testable import NutriScan

final class TextRecognitionUtilitiesTests: XCTestCase {

    func testExtractNutritionalInfo() {
            let textLines = [
                "Some irrelevant text",
                "Calories 250",
                "Protein / Protéines 15 g",
                "Carbohydrate / Glucides 30 g",
                "Fat / Lipides 10 g",
                "More irrelevant text"
            ]
            
            let result = extractNutritionalInfo(from: textLines)
            
            XCTAssertEqual(result.calories, 250, "Calories extraction is incorrect")
            XCTAssertEqual(result.protein, 15, "Protein extraction is incorrect")
            XCTAssertEqual(result.carbs, 30, "Carbs extraction is incorrect")
            XCTAssertEqual(result.fats, 10, "Fats extraction is incorrect")
        }

        func testExtractNutritionalInfoWithMissingData() {
            let textLines = [
                "Calories 200",
                // Protein data is missing
                "Carbohydrate / Glucides 25 g",
                // Fats data is missing
            ]
            
            let result = extractNutritionalInfo(from: textLines)
            
            XCTAssertEqual(result.calories, 200, "Calories extraction is incorrect")
            XCTAssertEqual(result.protein, 0, "Protein extraction should be 0 if missing")
            XCTAssertEqual(result.carbs, 25, "Carbs extraction is incorrect")
            XCTAssertEqual(result.fats, 0, "Fats extraction should be 0 if missing")
        }

        func testExtractNutritionalInfoWithNoData() {
            let textLines: [String] = []
            
            let result = extractNutritionalInfo(from: textLines)
            
            XCTAssertEqual(result.calories, 0, "Calories extraction should be 0 if no data")
            XCTAssertEqual(result.protein, 0, "Protein extraction should be 0 if no data")
            XCTAssertEqual(result.carbs, 0, "Carbs extraction should be 0 if no data")
            XCTAssertEqual(result.fats, 0, "Fats extraction should be 0 if no data")
        }

}
