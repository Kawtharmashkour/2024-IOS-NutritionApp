//
//  SocialMediaSignUpView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-23.
//

import SwiftUI

struct SocialMediaSignUpView: View {
    //@EnvironmentObject var SignupVM: SignUpViewModel
    //@EnvironmentObject var viewModel: AuthViewModel
    
    @StateObject var signUpViewModel = SignUpViewModel()
    @State private var isLoginViewPresented = false
    @State private var isLoggedIn = false
   
    
    
    var body: some View {
      NavigationStack {
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
                    
                    NavigationLink(
                                       destination: RegistrationView(), 
                                       isActive: $isLoggedIn, // Bind to the @State variable
                                       label: {
                                           EmptyView() // Empty view as label
                                       }
                                   )
                                }
                
              
                    NavigationLink(
                        destination: LoginView(),
                                      isActive: $isLoginViewPresented,
                                      label: {
                                          Button(action: {
                                              self.isLoginViewPresented = true
                                          }) {
                                              SignupLongItemView(objectText: "Email", backgroundColor: "loginButtonBackground")
                                          }
                                          .buttonStyle(PlainButtonStyle()) // Ensure the button doesn't get additional styles from NavigationLink
                                      }
                                  )
                    
                    
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
                
            }// VStack
        .navigationBarHidden(true) // Hides the navigation bar
        .onReceive(signUpViewModel.$isLogin) { isLogin in
                  if isLogin {
                      isLoggedIn = true // Set the @State variable to true when the user logs in
                  }
              }
    }
        }
  
#Preview {
    SocialMediaSignUpView()
}
