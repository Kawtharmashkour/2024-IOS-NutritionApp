import SwiftUI


struct RegistrationView: View {
    
    @State private var email = ""
    var gmail :String?
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
                    
                    if let gmail = gmail {
                        Inputview(text: Binding<String>(
                                     get: { gmail },
                                     set: { _ in }
                                 ), title: "Email Address", placeholder: "")
                            .disabled(true)
                            .padding(.leading)
                        // Set the email to Gmail if provided
                       
                                       
                    }
                    else{
                        Inputview(text: $email, title: "Email Address", placeholder: "name@example.com")
                        Text(emailError)
                            .foregroundColor(.red)
                            .padding(.leading)
                    }
                    
                    Inputview(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                    Text(fullnameError)
                        .foregroundColor(.red)
                        .padding(.leading)
                    
                    if passwordFieldsVisible {
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
                    }
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
        
        .onChange(of: [email, fullname, password, confirmPassword, height, weight, targetWeight]) { _ in
            
            if let gmail = gmail {
                            email = gmail
                        }
            emailError = Validation.validateEmail(email)
            fullnameError = Validation.validateFullName(fullname)
            passwordError = Validation.validatePassword(password)
            confirmPasswordError = Validation.validateConfirmedPassword(password,confirmPassword)
            heightError = Validation.validateHeight(height)
            weightError = Validation.validateWeight(weight)
            targetWeightError = Validation.validateWeight(targetWeight)
        }

    }
    
    var formIsValid: Bool {
        var isValid = true
        
        isValid = isValid && Validation.validateFullName(fullname).isEmpty
        isValid = isValid && Validation.validateHeight(height).isEmpty
        isValid = isValid && Validation.validateWeight(weight).isEmpty
        isValid = isValid && Validation.validateWeight(targetWeight).isEmpty
        
        // Only validate email and password fields if not signing in with Gmail
        if gmail == nil {
            isValid = isValid && Validation.validateEmail(email).isEmpty
            isValid = isValid && Validation.validatePassword(password).isEmpty
            isValid = isValid && Validation.validateConfirmedPassword(password, confirmPassword).isEmpty
           
        }
        
        return isValid
    }

    var passwordFieldsVisible: Bool {
          
           return gmail == nil
       }
    
    init(gmail: String? = nil) {
          self.gmail = gmail
        _email = State(initialValue: gmail ?? "")
          // Set password to "123456" if signing in with Gmail
          if gmail != nil {
              self._password = State(initialValue: "123456")
              self._confirmPassword = State(initialValue: "123456")
          }
      }
 }
#Preview {
    RegistrationView()
}
                                   

