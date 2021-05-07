//
//  ProfessorRatingViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 07/05/2021.
//

import Foundation

struct ProfessorRatingViewModel: Identifiable {
    var id: String = UUID().uuidString
    var profEmail: String = ""
    var userEmail: String = ""
    var myrating: Int = 0
}
