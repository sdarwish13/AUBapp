//
//  UserInfo.swift
//  AUB App
//
//  Created by Sara Darwish  on 18/03/2021.
//

import Foundation
import FirebaseAuth

class UserInfo : ObservableObject {
    enum AuthState {
        case undefined, signedIn, signedOut
    }
    @Published var isUserAuthenticated : AuthState = .undefined
    @Published var user: FBUser = .init(uid: "", name: "", email: "")
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let _ = user else {
                self.isUserAuthenticated = .signedOut
                return
            }
            self.isUserAuthenticated = .signedIn
        })
        
    }
}
