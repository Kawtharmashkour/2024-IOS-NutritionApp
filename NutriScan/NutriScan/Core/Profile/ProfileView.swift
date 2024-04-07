//
//  ProfileView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-19.
//

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
    @State private var editMode: EditMode = .inactive // Add an EditMode state
    @Environment(\.presentationMode) var presentationMode // Access presentationMode
    @AppStorage("calorieGoal") private var calorieGoal: Double = 1500
    @AppStorage("proteinGoal") private var proteinGoal: Double = 50
    @AppStorage("fatGoal") private var fatGoal: Double = 70
    @AppStorage("carbGoal") private var carbGoal: Double = 300
    
    var suggestion : String = ""
    var body: some View {
        NavigationView {
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
                    
                    Section{
                        Text("Your Age: \(user.age)")
                        
                        
                        Text("Your Activity Level: \(user.activityLevel)")
                        
                        
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
                            viewModel.signOut()
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
                                let (calculatedBMI, feedback) = Sugestion.BMICalculator(weight: user.doubleWeight ?? 0, height: user.doubleHeight ?? 0, gender: user.gender)
                                Text("BMI: \(String(format: "%.2f", calculatedBMI))")
                                Text("Feedback : \(feedback)")
                            }
                        }
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .font(.subheadline)
                    
                    
                    
                    Section("Suggestion for you") {
                        if let weight = user.doubleWeight,
                           let height = user.doubleHeight,
                          let suggestion = Sugestion.weightSugestion(idealBMI: 22.0, weight: weight, height: height),
                           let age = user.doubleAge {
                          Text(suggestion)
                          
                                let bmr = Sugestion.BMR(weight: weight, height: height, age: age, gender: user.gender)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Your Basal Metabolic Rate (BMR): ")
                                Text(String(format: "%.2f", bmr))                                         .foregroundColor(.red)
                            }
                           
                            if let tdee = Sugestion.TDEE(bmr: bmr, activityLevel: user.activityLevel) {
                                VStack(alignment: .leading, spacing: 5){
                                    Text("Your maximum daily calorie intake based on your activity level is: ")
                                    Text(String(format: "%.2f", tdee) + " calories")
                                        .foregroundColor(.red)
                            
                                }
                            } else {
                                Text("Invalid activity level")
                            }
                        } else {
                            Text("Missing user data") // Display a message if any of the user data is missing
                        }
                    }

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
                    
                    
                }//list
                .navigationBarTitle("Profile", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton, trailing: editButton)
                .environment(\.editMode, $editMode)
                .onAppear {
                    // Set isEditing to true when the view appears
                    editMode = .active
                }
            }else {
                LoginView()
            }
        }// Navigation/view
    } //body
    var editButton: some View {
        NavigationLink(destination: EditProfileView(), isActive: Binding<Bool>(get: {
            self.editMode == .active
        }, set: { newValue in
            if !newValue {
                self.editMode = .inactive
            }
        })) {
            Button(action: {
                editMode = editMode == .active ? .inactive : .active
            }) {
                Text(editMode == .active ? "Done" : "Edit")
            }
        }
    }
  //  Customisesd back button
    var backButton: some View {
        Button(action: {
            // Dismiss the current view
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 2) {
                Image(systemName: "chevron.left")
                Text("Back")
                    
            }
        }
        .accessibility(label: Text("Back")) // Optional: add accessibility label for screen readers
    }
    
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
  

