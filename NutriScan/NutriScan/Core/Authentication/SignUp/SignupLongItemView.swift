//
//  SignupLongItemView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-24.
//

import SwiftUI

struct SignupLongItemView: View {
    // MARK: PRPPERTIES
    let objectText: String
    let backgroundColor: String
    
    var body: some View {
        ZStack(alignment: .center){
            Text(objectText)
                .font(.body)
                .foregroundColor(.black)
        }//ZSTACK
        .frame(height: 60)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(
            Color(backgroundColor)
            .cornerRadius(5)
        )
    }
}

struct SignupLongItemView_Previews: PreviewProvider {

    static var previews : some View {
        
        SignupLongItemView(objectText: "Email", backgroundColor: "loginButtonBackground")
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}
