//
//  ProfileView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-17.
//

import SwiftUI

struct ProfileView: View {
    @State private var bmi = 0.0
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List{
                Section{
                    HStack {
                        Text(user.initials)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading, spacing:4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                        }
                    }
                }
                Section("general"){
                    HStack{
                        SettingsRowView(imageName: "gear", title: "Version", tintcolor: Color(.systemGray))
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                    }
                }
                
                Section( "Account"){
                    Button  {
                        print ("Sign Out ...")
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintcolor: .red)
                    }
                    
                    Button  {
                        print ("Sign Out ...")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintcolor: .red)
                    }
                    
                    
                }
                
                Section("BMI Calculation"){
                    VStack(alignment: .leading, spacing: 4){
                 
                            Text ("Your height : \(user.height) cm")
                            Text ("Your weight : \(user.weight) kg")
                            Text ("Your goal : \(user.targetWeight) kg")
                            
                        }
                        
                        HStack {
                            Image ("BMI")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.vertical,5)
                            
                            VStack(alignment: .leading, spacing:4){
                                let gender = user.gender
                                let (bmi, feedback) = BMICalculator(weight: 65, height: 170, gender :"Male")
                                Text ("BMI: \(bmi)")
                                
                                Text("Feedback : \(feedback)")
                            }
                        }
                    }
                .font(.system(size: 14))
                    .foregroundColor(.black)
                    .font(.subheadline)
            }
            
        }
        }
    
    func BMICalculator(weight: Double, height: Double, gender: String) -> (Double, String) {
        let heightInMeters = height / 100
        let BMI = weight / pow(heightInMeters, 2)
        let roundedBMI = round(BMI * 10) / 10
        
        var message = ""
        
        if gender == "Male" {
            if roundedBMI < 20 {
                message = "Underweight (Male)"
            } else if roundedBMI >= 20 && roundedBMI < 25 {
                message = "Normal weight (Male)"
            } else if roundedBMI >= 25 && roundedBMI < 30 {
                message = "Overweight (Male)"
            } else {
                message = "Obese (Male)"
            }
        } else if gender == "Female" {
            if roundedBMI < 19 {
                message = "Underweight (Female)"
            } else if roundedBMI >= 19 && roundedBMI < 24 {
                message = "Normal weight (Female)"
            } else if roundedBMI >= 24 && roundedBMI < 29 {
                message = "Overweight (Female)"
            } else {
                message = "Obese (Female)"
            }
        } else {
            // Handle unknown gender
            message = "Unknown gender"
        }
        
        return (roundedBMI, message)
    }

    
}
#Preview {
    ProfileView()
}

