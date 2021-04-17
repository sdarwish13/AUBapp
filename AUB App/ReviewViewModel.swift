//
//  ReviewViewModel.swift
//  AUB App
//
//  Created by Ghina Kamal on 17/04/2021.
//

import Foundation

struct ReviewViewModel: Identifiable {
    var id: String = UUID().uuidString
    var courseCode: String = ""
    var review: String = ""
    var timeDate: String = ""

}
