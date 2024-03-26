//
//  SwitchToLoginView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-24.
//

import SwiftUI

struct SwitchToLoginView: View {
    let title: String
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 3){
            Text(title)
                .font(.body)
            Button{
                
            } label: {
                Text("Login")
                    .foregroundColor(Color("hyperLink"))
            }
            
            
        }//HSTACK
    }
}

struct SwitchToLoginView_Previews: PreviewProvider {

    static var previews : some View {
        
        SwitchToLoginView (title: "Already onboard?")
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}
