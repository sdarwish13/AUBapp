//
//  SignInPage.swift
//  AUB App
//
//  Created by Ghina Kamal on 17/02/2021.
//

import SwiftUI
import Firebase

struct SignInPage: View {
    
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel()
    @Binding var showSheet: Bool
    @Binding var action: LoginView.Action?
    
    @State private var showAlert = false
    @State private var authError: EmailAuthError?
    let verticalPaddingForForm = 40.0
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 0.8, blue: 6), .white]), center: .center, startRadius: 50, endRadius: 470)
            
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                Text("Welcome!")
                    .font(.title)
                    .foregroundColor(Color.white)
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.secondary)
                    TextField("Enter your email", text: self.$user.email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .foregroundColor(Color.black)
                        .disableAutocorrection(true)
                }.padding()
                 .background(Color.white)
                 .cornerRadius(10)
                
                HStack {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15.0, height: 18.0)
                        .foregroundColor(.secondary)
                    SecureField("Enter password", text: self.$user.password)
                        .foregroundColor(Color.black)
                }.padding()
                 .background(Color.white)
                 .cornerRadius(10)
                HStack {
                    Spacer()
                    Button(action: {
                        self.showSheet = true
                        self.action = .resetPW
                        
                    }) {
                        Text("Forgot Password")
                            .foregroundColor(.white)
                            .underline()
                    }
                }
                VStack {
                    Button(action: {
                        FBAuth.authenticate(withEmail: self.user.email, password: self.user.password) { (result) in
                            switch result {
                            case .failure(let error):
                                self.authError = error
                                self.showAlert = true
                            case .success( _):
                                print("Signed In")
                            }
                        }
                    }) {
                        Text("Sign in")
                            .padding()
                            .frame(width: 200)
                        
                    }.background(Color.white)
                     .foregroundColor(Color.black)
                     .cornerRadius(10)
                     .disabled(!user.isLogInComplete)
                    Button(action: {
                        self.showSheet = true
                        self.action = .signUp
                        print(self.showSheet)
                        
                    }) {
                        Text("Sign up")
                            .padding()
                            .frame(width: 200)
                            .background(Color(red: 0.4, green: 0.8, blue: 6))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                    }
                }
                
            }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(self.authError?.localizedDescription ?? "Unknown Error"), dismissButton: .default(Text("OK")) {
                    if self.authError == .incorrectPassword {
                        self.user.password = ""
                    }
                    else {
                        self.user.password = ""
                        self.user.email = ""
                    }
                    })
            }
        }.padding(.top, -54)
         .padding(.bottom, -54)
    }
}

struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage(showSheet: .constant(false), action: .constant(.signUp))
    }
}
