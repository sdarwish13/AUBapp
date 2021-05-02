//
//  reviewsData.swift
//  courses
//
//  Created by Ghina Kamal on 18/03/2021.
//

import Foundation


struct Course: Identifiable {
    var id = UUID()
    var code: String
    var name: String
    var department: String
    var description: String
}

let testData = [
    Course(code: "King Ghina", name: "Introduction to Programming", department: "Computer Science", description: "I really enojoyed this course  "),
    Course(code: "Loser SaraH", name: "Calculus II", department: "Mathematics", description: "i learned Math and other stuff but I HATE my prof!!! "),
    Course(code: "Alidsncsowse ", name: "Artificial Intellingence", department: "Computer Science", description: "Go with prof saed 100%%%"),
    Course(code: "preson y", name: "Artificial Intellingence", department: "Computer Science", description: "Go with prof saed 100%%%"),
    Course(code: "preson x", name: "Artificial Intellingence", department: "Computer Science", description: "Go with prof saed 100%%%"),
    Course(code: "hello ", name: "Artificial Intellingence", department: "Computer Science", description: "Go with prof saed 100%%%"),
    Course(code: "person 23", name: "Artificial Intellingence", department: "Computer Science", description: "Go with prof saed 100%%%"),
    Course(code: "Jessie poo :)", name: "Final Year Project", department: "Computer Science", description: " idk this is a long review learn how to do project and other stuffdfghjkl; kjkhjghfgdfcvbn mnbvc drtyb mnhbgvc mjhgvcv mkjhgfvb mkuhg hjk hkjhv mjh ufgh jhbvbn gkf vhbg hfvhb fvgb gyv bu hvbb.jh lhgljkgvv bhkjhbnbl ugbnb hjkb jh ,hf jgkgulikuv hgbk ug bhkgyu ghjgh kghju jkhugkugk ghkhg uyg")
]
