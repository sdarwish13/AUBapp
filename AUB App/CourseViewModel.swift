//
//  CourseViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 07/04/2021.
//

import Foundation
import FirebaseFirestore

struct CourseViewModel: Identifiable {
    var id: String = UUID().uuidString
    var code: String = ""
    var name: String = ""
    var description: String = ""
    var department: String = ""
    var faculty: String = ""
        
    
    func isEmpty(_field: String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isCodeValid(_code: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@","[A-Z]{4}[0-9]{3}[A-Z]?")
        return test.evaluate(with: code)
    }
    
    func isFacultyValid(_faculty: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", "[A-Z]+")
        return test.evaluate(with: faculty)
    }
    
    var isAddCourseComplete: Bool {
        if  !isCodeValid(_code: code) ||
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
            return "Enter a valid course name (eg. Introduction to Programming)"
        }
    }
        
    var validCodeText: String {
        if isCodeValid(_code: code) {
            return ""
        } else {
            return "Enter a valid code (eg. CMPS200)"
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
    
    var validDescriptionText: String {
        if !isEmpty(_field: description) {
            return ""
        } else {
            return "Enter a valid course description."
        }
    }
}
