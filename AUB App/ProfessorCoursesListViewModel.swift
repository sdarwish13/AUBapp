//
//  ProfessorCoursesListViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 01/05/2021.
//

import Foundation
import Firebase

class ProfessorCoursesListViewModel: ObservableObject {
    @Published var courseprofs = [ProfessorCoursesViewModel]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("courseprof").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.courseprofs = documents.map { (queryDocumentSnapshot) -> ProfessorCoursesViewModel in
                let data = queryDocumentSnapshot.data()
                let courseCode = data["courseCode"] as? String ?? ""
                let profMail = data["profMail"] as? String ?? ""
                let id = data["id"] as? String ?? ""
                let profName = data["profName"] as? String ?? ""
                return ProfessorCoursesViewModel(id: id, courseCode: courseCode, profMail: profMail, profName: profName)
            }
        }
    }
}
