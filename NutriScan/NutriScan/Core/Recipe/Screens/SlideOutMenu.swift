//
//  ReportView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//
//

import SwiftUI

struct SlideOutMenu: View {
    @State private var isMenuOpen = true
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var isOverlayVisible: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            if isMenuOpen {
                Color.black .opacity(0.5)//comment
                    .navigationBarBackButtonHidden(true)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isMenuOpen = false
                        isOverlayVisible = false
                        //presentationMode.wrappedValue.dismiss()
                    }
                HStack {
                    Spacer()
                    NavigationView {
                        List {
                            
                            VStack {
                                
                                NavigationLink(destination: ProfileView()) {
                                    Text("Account")
                                        .padding()
                                }
                                
                                NavigationLink(destination: SettingView()) {
                                    Text("Settings")
                                    //.foregroundColor(.black)
                                        .padding()
                                }
                                HStack{
                                    Button  {
                                        viewModel.signOut()
                                        isMenuOpen = false
                                    } label: {
                                        Text("Sign Out")
                                            .foregroundColor(Color(.label)) // Default color
                                            .padding()
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        .navigationBarTitle("Menu")
                        
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.75)
                    .offset(x: isMenuOpen ? 0 : UIScreen.main.bounds.width)
                }
                
            }
        }
        .onDisappear{
            presentationMode.wrappedValue.dismiss()
        }
    }
    }

