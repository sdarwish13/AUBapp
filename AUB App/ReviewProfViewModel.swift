//
//  ReviewProfViewModel.swift
//  AUB App
//
//  Created by Ghina Kamal on 15/05/2021.
//

import SwiftUI

struct ReviewProfViewModel: Identifiable {
    var id: String = UUID().uuidString
    var email: String = ""
    var name: String = ""
    var profEmail: String = ""
    var review: String = ""
    var timeDate: String = ""
    

}
