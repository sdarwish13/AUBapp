//
//  LoginView.swift
//  AUB App
//
//  Created by Sara Darwish  on 19/03/2021.
//

import SwiftUI

struct LoginView: View {
    enum Action {
        case signUp, resetPW, nothing
    }
    @State private var showsheet = false
    @State private var action : Action? = .nothing
    
    var body: some View {
        SignInPage(showSheet: $showsheet, action: $action).sheet(isPresented: $showsheet, content: {
            if self.action == .signUp {
                SignUpPage()
            }
            else if self.action == .resetPW {
                ForgotPasswordView()
            }
            else if self.action == .nothing {
                Text("this is the bug")
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
