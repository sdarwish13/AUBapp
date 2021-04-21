//
//  SignUpPage.swift
//  AUB App
//
//  Created by Sara Darwish  on 23/02/2021.
//

import SwiftUI


struct SignUpPage: View {
    @EnvironmentObject var userInfo : UserInfo
    @State var user: UserViewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    @State private var errorString = ""
    
    let verticalPaddingForForm = 40.0
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 0.8, blue: 6), .white]), center: .center, startRadius: 50, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    
                    VStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.secondary)
                                TextField("Enter your full name ", text: self.$user.fullname)
                                    .foregroundColor(Color.black)
                                    .autocapitalization(.words)
                                
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !user.validNameText.isEmpty {
                                Text(user.validNameText).font(.caption).foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.secondary)
                                TextField("Enter an email ", text: self.$user.email)
                                    .foregroundColor(Color.black)
                                    .autocapitalization(.none)
                                    .keyboardType(.emailAddress)
                                    .disableAutocorrection(true)
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            
                            if !user.validEmailAddressText.isEmpty {
                                Text(user.validEmailAddressText).font(.caption).foregroundColor(.red)
                            }
                        }
                    }
                    
                    VStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.secondary)
                                SecureField("Enter password", text: self.$user.password)
                                    .foregroundColor(Color.black)
                                
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            
                            if !user.validPasswordText.isEmpty {
                                Text(user.validPasswordText).font(.caption).foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.secondary)
                                SecureField("Confirm password", text: self.$user.confirmPassword)
                                    .foregroundColor(Color.black)
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !user.passwordsMatch(_confirmPW: user.confirmPassword) {
                                Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.red)
                            }
                        }
                    }
                    
                    Button(action: {
                        FBAuth.createUser(withEmail: self.user.email, name: self.user.fullname, password: self.user.password) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                            case .success( _):
                                print("Account Created Successfully")
                            }
                        }
                    }) {
                        Text("Sign up")
                            .padding()
                            .frame(width: 200)
                            .opacity(user.isSignInComplete ? 1 : 0.75)
                        
                    }.background(Color(red: 0.4, green: 0.8, blue: 6))
                     .foregroundColor(.white)
                     .cornerRadius(10)
                     .disabled(!user.isSignInComplete)
                    
                }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            }.padding(.top, -54)
             .padding(.bottom, -54)
          
            .alert(isPresented: $showError) {
                Alert(title: Text("Error creating account"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
            }
             .navigationBarTitle("Sign Up", displayMode: .inline)
             .navigationBarItems(trailing: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
             })
        }
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
