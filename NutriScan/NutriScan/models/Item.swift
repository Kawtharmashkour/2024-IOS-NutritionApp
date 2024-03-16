//
//  Item.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-15.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
