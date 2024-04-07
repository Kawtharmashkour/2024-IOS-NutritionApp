//
//  SettingView.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-03-24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        ScrollView {
            VStack {
                // Premium Version Section
                VStack {
                    HStack{
                        Text("Premium Version")
                        Image(systemName: "crown.fill")
                            .foregroundColor(.yellow)
                    }
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    Text("Unlimited Stations")
                        .foregroundColor(.white)
                        .padding()
                    Text("Remove Ads")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.black)
                .cornerRadius(10)
                .padding()
                
                // In App Purchase Section
                VStack(alignment: .leading) {
                    Text("In App Purchase")
                        .font(.title2)
                        .padding(.bottom)
                    
                    HStack {
                        Image(systemName: "crown.fill")
                        Text("Upgrade Premium")
                        Spacer()
                        // Add your action or navigation for Upgrade Premium
                        Image(systemName: "chevron.right")
                    }
                    .padding(.vertical)
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "cart.fill")
                        Text("InStore Purchase")
                        Spacer()
                        // Add your action or navigation for InStore Purchase
                        Image(systemName: "chevron.right")
                    }
                    .padding(.vertical)
                    
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
                
                
                Spacer()
                // Spresd the word Section
                VStack(alignment: .leading) {
                    Text("Spred the Word")
                        .font(.title2)
                        .padding(.bottom)
                    
                    HStack {
                        Image(systemName:"star")
                        Text("Rate App")
                        
                    }
                    .padding(.vertical)
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share App")
                        
                    }
                    .padding(.vertical)
                    Divider()
                    
                        HStack{
                            SettingsRowView(imageName: "gear", title: "Version", tintcolor: Color(.systemGray))
                            Spacer()
                            
                            Text("1.0.0")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                        }
        
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
                
                
                
                
                // Support & Privacy Section
                VStack(alignment: .leading) {
                    Text("Support & Privacy")
                        .font(.title2)
                        .padding(.bottom)
                    
                    HStack {
                        Image(systemName: "envelope")
                        Text("E-Mail us")
                        
                    }
                    .padding(.vertical)
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "lock")
                        Text("Privacy Policy")
                        
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Image(systemName: "doc.text")
                        Text("Terms of Use")
                       
                    }
                    .padding(.vertical)
                    
                    
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
                
            }
            .navigationTitle("Settings")
            .padding()
        }
    }
}

#Preview {
    SettingView()
}
