//
//  SocialMediaSignUpView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-23.
//

import SwiftUI

struct SocialMediaSignUpView: View {
    @EnvironmentObject var SignupVM: SignUpViewModel
    @StateObject var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            //Logo
            Image("Designer-6")
                .resizable()
                .scaledToFit()
                .frame(height:100)
                .padding(.vertical, UIScreen.main.bounds.size.height / 10)
            
            
            VStack(alignment: .leading, spacing: 10){
                
                //Signup with social Title
              SignUpTitleView(title: "Get started with")
                    .padding(.vertical)
                
                //SignUp with social
                SignupItemGroupView()
                
                Spacer()
                    .frame(height: 30)
                
                //Signup with email title
                SignUpTitleView(title: "Or sign up with")
                      .padding(.vertical)
                
                //Signup with email
                Button {
                    
                } label :{
                    SignupLongItemView(objectText: "Email", backgroundColor: "loginButtonBackground")
                }
                
                //Sign out from google
                //Signup with email
                Button {
                    signUpViewModel.signOutFromGoogle()
                } label :{
                    SignupLongItemView(objectText: "Google sign out", backgroundColor: "loginButtonBackground")
                }
                //Switch to login porchain
                Spacer()
            }//VStack
            
            .frame(width: 325)
            
            SwitchToLoginView (title: "Already onboard?")
                .padding(.bottom,UIApplication
                    .shared.windows
                    .first?
                    .safeAreaInsets
                    .bottom )
            
        } // VStack
    }
}

#Preview {
    SocialMediaSignUpView()
}
