//
//  CourseRatingViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 05/05/2021.
//

import Foundation

struct CourseRatingViewModel: Identifiable {
    var id: String = UUID().uuidString
    var courseCode: String = ""
    var userEmail: String = ""
    var myrating: Int = 0
}
