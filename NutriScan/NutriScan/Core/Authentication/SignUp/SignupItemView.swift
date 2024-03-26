//
//  SignupItemView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-24.
//

import SwiftUI

struct SignupItemView: View {
    //MARK: - PROPERTIES
    let backgroundColor: String
    let image: String
    
    //MARK: - BODY
    var body: some View {
        ZStack{
          Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 25, alignment: .center)
            
        }//ZSTACK
        .frame(width: 85, height: 60, alignment: .center)
        .background(
            Color(backgroundColor)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 5, x:0,y:1)
            )
            
        
    }
}

#Preview {
    SignupItemView(backgroundColor: "facebookColor" , image: "facebook")
        .previewLayout(.sizeThatFits)
        .padding()
    
}
