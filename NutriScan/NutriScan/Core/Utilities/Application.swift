//
//  Application.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-24.
//

import SwiftUI
//final class ApplicationUtility {
extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
    
}
