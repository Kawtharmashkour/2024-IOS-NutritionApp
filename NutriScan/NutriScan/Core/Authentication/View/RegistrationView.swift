import SwiftUI


struct RegistrationView: View {
    
    @State private var email = ""
    @State private var emailError = ""
    @State private var fullname = ""
    @State private var fullnameError = ""
    @State private var password = ""
    @State private var passwordError = ""
    @State private var confirmPassword = ""
    @State private var confirmPasswordError = ""
    @State private var weight = ""
    @State private var weightError = ""
    @State private var targetWeight = ""
    @State private var targetWeightError = ""
    @State private var height = ""
    @State private var heightError = ""
    @State private var selectedGender: String? = "Male"
    let genders = ["Male", "Female"]
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
       ScrollView {
            VStack{
                Image("nutrition")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.vertical, 5)
                
                VStack(alignment: .leading, spacing: 10){
                    Inputview(text: $email, title: "Email Address", placeholder: "name@example.com")
                    Text(emailError)
                        .foregroundColor(.red)
                        .padding(.leading)
                    
                    Inputview(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                    Text(fullnameError)
                        .foregroundColor(.red)
                        .padding(.leading)
                    
                    Inputview(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                    Text(passwordError)
                        .foregroundColor(.red)
                        .padding(.leading)
                    
                    ZStack(alignment: .trailing){
                        Inputview(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                    Text(confirmPasswordError)
                        .foregroundColor(.red)
                        .padding(.leading)
                    
                    Inputview(text: $height, title: "Height", placeholder: "Enter your height(cm)")
                        .keyboardType(.decimalPad)
                    Text(heightError)
                        .foregroundColor(.red)
                        .padding(.leading)
                    
                    Inputview(text: $weight, title: "Weight", placeholder: "Enter your weight(kg)")
                        .keyboardType(.decimalPad)
                    Text(weightError)
                        .foregroundColor(.red)
                        .padding(.leading)
                    
                    Inputview(text: $targetWeight, title: "Target Weight", placeholder: "Enter your target (kg)")
                        .keyboardType(.decimalPad)
                    Text(targetWeightError)
                        .foregroundColor(.red)
                        .padding(.leading)
                    
                    Text("Gender")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    HStack{
                        ForEach(genders, id: \.self) { gender in
                            Button(action: {
                                self.selectedGender = gender
                            }) {
                                HStack {
                                    if self.selectedGender == gender {
                                        Image(systemName: "largecircle.fill.circle").foregroundColor(.green)
                                    } else {
                                        Image(systemName: "circle")
                                    }
                                    Text(gender)
                                }
                            }
                            .font(.subheadline)
                            .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 3)
            
            Button {
                Task{
                    guard let gender = selectedGender else {
                        return
                    }
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname, height: height, weight: weight, targetWeight: targetWeight, gender: gender)
                }
            } label: {
                HStack{
                    Text("Signu up")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32 , height: 48)
            }
            .background(Color(.systemGreen))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1 : 0.5)
            .cornerRadius(10)
            .padding(.bottom, 10)
            .padding(.top, 10)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack{
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .foregroundColor(.green)
                .font(.system(size: 16))
            }
        }
        .onChange(of: email) { newValue in
            emailError = validateEmail(newValue)
        }
        .onChange(of: fullname) { newValue in
            fullnameError = validateFullName(newValue)
        }
        .onChange(of: password) { newValue in
            passwordError = validatePassword(newValue)
        }
        .onChange(of: confirmPassword) { newValue in
            confirmPasswordError = validateConfirmedPassword(newValue)
        }
        .onChange(of: height) { newValue in
            heightError = validateHeight(newValue)
        }
        .onChange(of: weight) { newValue in
            weightError = validateWeight(newValue)
        }
        .onChange(of: targetWeight) { newValue in
            targetWeightError = validateWeight (newValue)
        }
    }
    
    var formIsValid: Bool {
        return emailError.isEmpty && fullnameError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty && heightError.isEmpty && weightError.isEmpty && targetWeightError.isEmpty
    }
    
    private func validateEmail(_ email: String) -> String {
        return email.isEmpty ? "Email can not be empty" : !isValidEmail(email) ? "Invalid email format" : ""
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func validateFullName(_ fullname: String) -> String {
        return fullname.isEmpty ? "Full name can not be empty" : !isValidFullName(fullname) ? "Invalid name format" : ""
    }
    
    func isValidFullName(_ name: String) -> Bool {
        let nameRegex = "^[a-zA-Z ]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
    private func validatePassword(_ password: String) -> String {
        return password.isEmpty ? "Password can not be empty" : !isValidPassword(password) ? "Invalid password format" : ""
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$&*]).{6,15}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    private func validateConfirmedPassword(_ confirmedPassword: String) -> String {
        return confirmedPassword.isEmpty ? "Confirmed password can not be empty" : !isValidConfirmedPassword(confirmedPassword) ?"Passwords do not match" : ""
    }
    func isValidConfirmedPassword(_ confirmedPassword: String) -> Bool {
        return password == confirmedPassword
    }

    private func validateWeight(_ weight: String) -> String {
        return weight.isEmpty ? "Weight can not be empty" : !isValidWeight(weight) ? "Inavalid Weight format" : ""
    }
    
    func isValidWeight(_ weight: String) -> Bool {
        let nameRegex = "^[0-9]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: weight)
    }
    private func validateHeight(_ height: String) -> String {
        return height.isEmpty ? "Height can not be empty" : !isValidHeight(height) ? "Inavalid height format" : ""
    }
    
    func isValidHeight(_ height: String) -> Bool {
        let nameRegex = "^[0-9]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: height)
    }
    
}
//    var formIsValid: Bool {
//
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//        let fullNameRegex = "^[a-zA-Z ]+$"
//        let fullNamePredicate = NSPredicate(format: "SELF MATCHES %@", fullNameRegex)
//        let passwordRegex = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$&*]).{6,15}$"
//        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
//
//        emailError = email.isEmpty ? "Email can not be empty" : !emailPredicate.evaluate(with: email) ? "Invalid email format" : ""
//        fullnameError = fullname.isEmpty ? "Full name cannot be empty" : !fullNamePredicate.evaluate(with: fullname) ? "Invalid full name format" : ""
//        passwordError = password.isEmpty ? "Password cannot be empty" : !passwordPredicate.evaluate(with: password) ? "Password must be 6-15 characters long and contain at least one letter, one number, and one special character" : ""
//        confirmPasswordError = confirmPassword != password ? "Passwords do not match" : ""
//        heightError = height.isEmpty ? "Height cannot be empty" : ""
//        weightError = weight.isEmpty ? "Weight cannot be empty" : ""
//        targetWeightError = targetWeight.isEmpty ? "Target weight cannot be empty" : ""
//
//        return emailError.isEmpty && fullnameError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty && heightError.isEmpty && weightError.isEmpty && targetWeightError.isEmpty
//    }
//}

#Preview {
    RegistrationView()
}
