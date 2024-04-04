//
//  CustomViewModifiers.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-04-04.
//

import SwiftUI

struct IconModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 42, height: 42, alignment: .center)
    }
}
