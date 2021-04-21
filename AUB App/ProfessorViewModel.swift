//
//  ProfessorViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 17/04/2021.
//

import Foundation

struct ProfessorViewModel: Identifiable {
    var id: String = UUID().uuidString
    var name: String = ""
    var email: String = ""
    var officeHours: String = ""
    var department: String = ""
    var faculty: String = ""
    
    
    func isEmpty(_field: String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isEmailValid(_email: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@","[a-zA-Z0-9]*@aub.edu.lb")
        return test.evaluate(with: email)
    }
    
    func isFacultyValid(_faculty: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", "[A-Z]+")
        return test.evaluate(with: faculty)
    }
    
    func isOfficeHValid(_officeHours: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", "[A-Z]{0,5}[\\s][0-9][-][0-9]")
        return test.evaluate(with: officeHours)
    }
    
    var isAddProfessorComplete: Bool {
        if  !isEmailValid(_email: email) ||
            isEmpty(_field: name) ||
            !isFacultyValid(_faculty: faculty){
            return false
        }
        return true
    }
    
    var validNameText: String {
        if !isEmpty(_field: name) {
            return ""
        } else {
            return "Enter a valid professor name (eg. Saeed Raheel)"
        }
    }
        
    var validEmailText: String {
        if isEmailValid(_email: email) {
            return ""
        } else {
            return "Enter a valid email (eg. sr47@aub.edu.lb)"
        }
    }
    
    var validDepartmentText: String {
        if !isEmpty(_field: department) {
            return ""
        } else {
            return "Enter a valid department (eg. Computer Science)"
        }
    }
    
    var validFacultyText: String {
        if isFacultyValid(_faculty: faculty) {
            return ""
        } else {
            return "Must be all capital letters (eg. FAS)"
        }
    }
    
    var validOfficeHText: String {
        if isOfficeHValid(_officeHours: officeHours) {
            return ""
        } else {
            return "Enter a valid office hourse (eg. MW 3-4)"
        }
    }
}
