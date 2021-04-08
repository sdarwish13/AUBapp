//
//  AllCoursesViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 07/04/2021.
//

import Foundation
import Firebase

class AllCoursesViewModel: ObservableObject {
    @Published var courses = [CourseViewModel]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("courses").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.courses = documents.map { (queryDocumentSnapshot) -> CourseViewModel in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let code = data["code"] as? String ?? ""
                let department = data["department"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let faculty = data["faculty"] as? String ?? ""
                return CourseViewModel(code: code, name: name, description: description, department: department, faculty: faculty)
            }
        }
    }

}
