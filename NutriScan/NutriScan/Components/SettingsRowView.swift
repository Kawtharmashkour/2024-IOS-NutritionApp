//
//  SettingsRowView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-17.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintcolor: Color
    
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
             .foregroundColor(tintcolor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            
            
            
        }
    }
}

#Preview {
    SettingsRowView(imageName : "gear", title: "Version", tintcolor: Color(.systemGray))
}

