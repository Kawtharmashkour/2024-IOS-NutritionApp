//
//  SettingView.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-03-24.
//

import SwiftUI

struct SettingView: View {
    @State private var calorieGoal: Double = 1500
    @State private var proteinGoal: Double = 50
    @State private var fatGoal: Double = 70
    @State private var carbGoal: Double = 300
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
                
                // Your Daily Goal Section
                VStack(alignment: .leading) {
                    Text("Your Daily Goal")
                        .font(.title2)
                        .padding(.bottom)
                    // Calorie goal slider
                    VStack {
                        HStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(.red)
                                
                            Text("Calories")
                            Spacer()
                            Text("\(Int(calorieGoal))")
                        }
                        Slider(value: $calorieGoal, in: 500...4000, step: 50)
                            .accentColor(.red)
                    }
                    // Protein goal slider
                    VStack {
                        HStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(.green)
                            Text("Protein")
                            Spacer()
                            Text("\(Int(proteinGoal))")
                        }
                        Slider(value: $proteinGoal, in: 10...200, step: 5)
                            .accentColor(.green)
                    }
                    // Fat goal slider
                    VStack {
                        HStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(.blue)
                            Text("Fat")
                            Spacer()
                            Text("\(Int(fatGoal))")
                        }
                        Slider(value: $fatGoal, in: 0...150, step: 5)
                            .accentColor(.blue)
                    }
                    
                    // Carb goal slider
                    VStack {
                        HStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(.yellow)
                            Text("Carbs")
                            Spacer()
                            Text("\(Int(carbGoal))")
                        }
                        Slider(value: $carbGoal, in: 0...500, step: 10)
                            .accentColor(.yellow)
                    }
                    
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
