//
//  CourseProfessorsViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 01/05/2021.
//

import Foundation

struct CourseProfessorsViewModel: Identifiable {
    var id: String = UUID().uuidString
    var courseCode: String = ""
    var profMail: String = ""
}
