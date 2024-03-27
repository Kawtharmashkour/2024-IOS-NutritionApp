//
//  EditProfileView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-26.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var fullname: String = ""
    @State private var email: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var targetWeight: String = ""

    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Full Name", text: $fullname)
                TextField("Email", text: $email)
                TextField("Height (cm)", text: $height)
                    .keyboardType(.numberPad)
                TextField("Weight (kg)", text: $weight)
                    .keyboardType(.numberPad)
                TextField("Target Weight (kg)", text: $targetWeight)
                    .keyboardType(.numberPad)
            }

            Section {
                Button("Save Changes") {
                    // Call a function to save changes
                    saveChanges()
                }
            }
        }
        .onAppear {
            // Populate fields with existing user data
            if let user = viewModel.currentUser {
                fullname = user.fullname
                email = user.email
                height = "\(user.height)"
                weight = "\(user.weight)"
                targetWeight = "\(user.targetWeight)"
            }
        }
        .navigationTitle("Edit Profile")
    }

    func saveChanges() {
        // Validate input and update user profile
        guard let currentUser = viewModel.currentUser else {
            return
        }

        // Validate input fields (you can reuse your existing validation logic)

        // Update user profile with new data
//        viewModel.updateUserProfile(
//            userId: currentUser.id,
//            fullname: fullname,
//            email: email,
//            height: Double(height) ?? 0,
//            weight: Double(weight) ?? 0,
//            targetWeight: Double(targetWeight) ?? 0
//        )

        // Dismiss the view, or perform any other necessary action
        // For example:
        // presentationMode.wrappedValue.dismiss()
    }
}

