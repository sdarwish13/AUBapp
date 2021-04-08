//
//  ForgotPasswordView.swift
//  AUB App
//
//  Created by Sara Darwish  on 19/03/2021.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var user: UserViewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
        
    @State private var showAlert = false
    @State private var errorString: String?
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 0.8, blue: 6), .white]), center: .center, startRadius: 50, endRadius: 470)
                
                VStack {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.secondary)
                        TextField("Enter your email adress ", text: $user.email)
                            .foregroundColor(Color.black)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                        
                    }.padding()
                     .background(Color.white)
                     .cornerRadius(10)
                    
                    Button(action: {
                        FBAuth.resetPassword(email: self.user.email) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                            case .success( _):
                                break
                            }
                            self.showAlert = true
                        }
                    }) {
                        Text("Reset")
                            .frame(width: 200)
                            .padding(.vertical, 15)
                            .background(Color(red: 0.4, green: 0.8, blue: 6))
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .opacity(user.isEmailValid(_email: user.email) ? 1 : 0.75)
                    }
                    .disabled(!user.isEmailValid(_email: user.email))
                    Spacer()
                }.padding(.top)
                 .frame(width: 300)
             
            }.padding(.bottom, -54)
             .navigationBarTitle("Request a password reset", displayMode: .inline)
             .navigationBarItems(trailing: Button("Dismiss") {
                 self.presentationMode.wrappedValue.dismiss()
             })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"), message: Text(self.errorString ?? "Success. Reset email sent successfully. Check your email."), dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
