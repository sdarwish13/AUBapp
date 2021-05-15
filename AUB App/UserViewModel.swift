//
//  UserViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 19/03/2021.
//

import Foundation

struct UserViewModel {
    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    var confirmPassword: String = ""
    var isadmin: Int = 0
        
    func passwordsMatch(_confirmPW:String) -> Bool {
        return _confirmPW == password
    }
    
    func isEmpty(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isEmailValid(_email: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@mail.aub.edu")
        return passwordTest.evaluate(with: email)
    }
    
    func isPasswordValid(_password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    var isSignInComplete: Bool {
        if  !isEmailValid(_email: email) ||
            isEmpty(_field: fullname) ||
            !isPasswordValid(_password: password) ||
            !passwordsMatch(_confirmPW: confirmPassword){
            return false
        }
        return true
    }
    
    var isLogInComplete: Bool {
        if isEmpty(_field: email) ||
            isEmpty(_field: password) {
            return false
        }
        return true
    }
    
    var validNameText: String {
        if !isEmpty(_field: fullname) {
            return ""
        } else {
            return "Enter your full name."
        }
    }
        
    var validEmailAddressText: String {
        if isEmailValid(_email: email) {
            return ""
        } else {
            return "Enter your aub email address (eg. xxx00@mail.aub.edu)"
        }
    }
    
    var validPasswordText: String {
        if isPasswordValid(_password: password) {
            return ""
        } else {
            return "Must be 8 characters containing at least one number and one Capital letter."
        }
    }
    
    var validConfirmPasswordText: String {
        if passwordsMatch(_confirmPW: confirmPassword) {
            return ""
        } else {
            return "Password fields do not match."
        }
    }
}
