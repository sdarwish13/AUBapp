//
//  ProfessorCoursesViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 01/05/2021.
//

import Foundation

struct ProfessorCoursesViewModel: Identifiable {
    var id: String = UUID().uuidString
    var courseCode: String = ""
    var profMail: String = ""
    var profName: String = ""
}
