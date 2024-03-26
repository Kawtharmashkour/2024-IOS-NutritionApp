//
//  SignUpTitleView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-24.
//

import SwiftUI

struct SignUpTitleView: View {
    //MARK: properties
     let title: String
    
    var body: some View {
        //MARK : BODY
        HStack(alignment: .firstTextBaseline, spacing: 0 ){
            Text(title)
                .font(.body)
                .padding(.horizontal,10)
        }//HSTACK
       
    }
}

struct SignUpTitleView_Preview: PreviewProvider {
    static var previews: some View {
         SignUpTitleView(title: "Get started!")
    }
}
