//
//  LoginView.swift
//  AUB App
//
//  Created by Sara Darwish  on 19/03/2021.
//

import SwiftUI

struct LoginView: View {
    enum Action {
        case signUp, resetPW
    }
    @State private var showsheet = false
    @State private var action : Action?
    
    var body: some View {
        SignInPage(showSheet: $showsheet, action: $action).sheet(isPresented: $showsheet, content: {
            if self.action == .signUp {
                SignUpPage()
            }
            else if self.action == .resetPW {
                ForgotPasswordView()
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
