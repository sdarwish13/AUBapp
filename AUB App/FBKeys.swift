//
//  FBKeys.swift
//  AUB App
//
//  Created by Sara Darwish  on 19/03/2021.
//

import Foundation
enum FBKeys {
    
    enum CollectionPath {
        static let users = "users"
        static let courses = "courses"
    }
    
    enum User {
        static let uid = "uid"
        static let name = "name"
        static let email = "email"
        static let isadmin = "isadmin"
    }
    enum Course {
        static let code = "code"
        static let name = "name"
        static let description = "description"
        static let department = "department"
        static let faculty = "faculty"
    }
}
