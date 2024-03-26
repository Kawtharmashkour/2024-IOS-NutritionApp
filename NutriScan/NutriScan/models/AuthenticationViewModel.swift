////
////  AuthenticationViewModel.swift
////  NutriScan
////
////  Created by Shadan Farahbakhsh on 2024-03-22.
////
//
//import Firebase
//import GoogleSignIn
//
//class AuthenticationViewModel: ObservableObject {
//    
//    //
//    enum SignInState{
//        case  signedIn
//        case signedOut
//        
//    }
//    
//    @Published var state: SignInState = .signedOut
//    
//    
//    func signIn() {
//        // 1
//        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
//            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
//                authenticateUser(for: user, with: error)
//            }
//        } else {
//            // 2
//            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//            
//            // 3
//            let configuration = GIDConfiguration(clientID: clientID)
//            
//            // 4
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
//            
//            // 5
////            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
////                authenticateUser(for: user, with: error)
////            }
//            GIDSignIn.sharedInstance.signIn(with: .nil, presenting: rootViewController) { [unowned self] user, error in
//                if let error = error {
//                    print("Error signing in: \(error.localizedDescription)")
//                    return
//                }
//                authenticateUser(for: user, with: error)
//            }
//
//
//        }
//    }
//    //Handle the error and return it early from the method.Get the idToken and accessToken //from the user instance.Use them to sign in to Firebase. If there are no errors, //change the state to signedIn.
//
//
//    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
//      // 1
//      if let error = error {
//        print(error.localizedDescription)
//        return
//      }
//      
//      // 2
//      guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
//      
//        
//      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
//      
//      // 3
//      Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
//        if let error = error {
//          print(error.localizedDescription)
//        } else {
//          self.state = .signedIn
//        }
//      }
//    }
//
//    func signOut() {
//      // 1
//      GIDSignIn.sharedInstance.signOut()
//      
//      do {
//        // 2
//        try Auth.auth().signOut()
//        
//        state = .signedOut
//      } catch {
//        print(error.localizedDescription)
//      }
//    }
//
//    
//}
