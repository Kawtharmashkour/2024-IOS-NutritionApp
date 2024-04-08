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
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
               // .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isMenuOpen = false
                    }
                }
            
            SlideMenuView(isMenuOpen: $isMenuOpen)
                .offset(x: isMenuOpen ? 0 : UIScreen.main.bounds.width * 0.75)
                //.animation(.easeInOut)
        }
        .frame(width: UIScreen.main.bounds.width * 0.75)
        .offset(x: isMenuOpen ? 0 : UIScreen.main.bounds.width * 0.75)
        .background(.green)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        withAnimation {
                            isMenuOpen = false
                        }
                    }
                }
        )
        .ignoresSafeArea(.keyboard)
    }
}

struct SlideMenuView: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        
        NavigationStack{
            Spacer()
            VStack {
                NavigationLink(destination: ProfileView()) {
                                    Text("Account")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                .navigationBarBackButtonHidden(true)
                NavigationLink(destination: ProfileView()) {
                                    Text("Sign Out")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                Button(action: {
                    // Handle settings action
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    Text("Settings")
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .cornerRadius(10)
            .padding()
            Spacer()
        }
    }
}

struct SlideOutMenu_Previews: PreviewProvider {
    static var previews: some View {
        SlideOutMenu()
    }
}
