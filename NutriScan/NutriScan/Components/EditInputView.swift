//
//  EditInputView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-30.
//

import SwiftUI

struct EditInputview: View {
    @Binding var text: String
    let title: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
        Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField{
                SecureField("",text: $text)
                    .font(.system(size: 14))
            }else{
                TextField("",text: $text)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}

#Preview {
    EditInputview(text: .constant(""), title: "Email Address")
}

