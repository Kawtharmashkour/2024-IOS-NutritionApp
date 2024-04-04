//
//  TextRecognitionUtilities.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-04-03.
//

import Foundation

func extractNutritionalInfo(from textLines: [String]) -> (calories: Double, protein: Double, carbs: Double, fats: Double) {
    var calories = 0.0
    var protein = 0.0
    var carbs = 0.0
    var fats = 0.0

    // Example regex patterns, adjust based on expected text format
    let caloriesPattern = "Calories: (\\d+)"
    let proteinPattern = "Protein: (\\d+)g"
    let carbsPattern = "Carbs: (\\d+)g"
    let fatsPattern = "Fats: (\\d+)g"

    for line in textLines {
        if let caloriesMatch = line.matchingRegex(caloriesPattern) {
            calories = Double(caloriesMatch) ?? 0
        }
        if let proteinMatch = line.matchingRegex(proteinPattern) {
            protein = Double(proteinMatch) ?? 0
        }
        if let carbsMatch = line.matchingRegex(carbsPattern) {
            carbs = Double(carbsMatch) ?? 0
        }
        if let fatsMatch = line.matchingRegex(fatsPattern) {
            fats = Double(fatsMatch) ?? 0
        }
    }

    return (calories, protein, carbs, fats)
}

extension String {
    func matchingRegex(_ pattern: String) -> String? {
        if let regex = try? NSRegularExpression(pattern: pattern, options: []),
            let result = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)),
            let range = Range(result.range(at: 1), in: self) {
                return String(self[range])
        }
        return nil
    }
}

