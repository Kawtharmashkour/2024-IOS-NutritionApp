//
//  GeneralFunc.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-25.
//

import Foundation

struct GeneralFunc{
    static func Number2DigitsAfterpoint(number: Double) -> String {
      
       return String(format: "%.2f", (number * 100).rounded() / 100)
        
    }
}
