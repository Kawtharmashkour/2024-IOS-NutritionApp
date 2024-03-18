//
//  InputView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-17.
//

import SwiftUI

struct Inputview: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
        Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            }else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}

#Preview {
    Inputview(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
