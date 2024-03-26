//
//  SignupItemGroupView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-24.
//

import SwiftUI

struct SignupItemGroupView: View {
    @EnvironmentObject var SignupVM: SignUpViewModel
    @StateObject var signUpViewModel = SignUpViewModel() 
    
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
            //FACEBOOK
            Button {
                
            } label: {
                SignupItemView(backgroundColor: "facebookColor", image: "facebook")
            }
            
            //GOOGLE
            Button {
                signUpViewModel.signUpWithGoogle() 
            } label: {
                SignupItemView(backgroundColor: "googleColor", image: "Google")
            }
            
            //TWITTER(X)
            Button {
                
            } label: {
                SignupItemView(backgroundColor: "XColor", image: "x")
            }
            
        }//HSTACK
    }
}

#Preview {
    SignupItemGroupView()
}
