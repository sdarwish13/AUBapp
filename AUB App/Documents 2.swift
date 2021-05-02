//
//  Documents.swift
//  AUB App
//
//  Created by Sara Darwish  on 25/02/2021.
//

import Foundation


struct Document: Identifiable {
    var id = UUID()
    var name: String
}

let testData2 = [
    Document(name: "Exam1"), Document(name: "Exam2"), Document(name: "Final")
]
