//
//  CourseProfessorsListViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 01/05/2021.
//

import Foundation
import Firebase

class CourseProfessorsListViewModel: ObservableObject {
    @Published var courseprofs = [CourseProfessorsViewModel]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("courseprof").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.courseprofs = documents.map { (queryDocumentSnapshot) -> CourseProfessorsViewModel in
                let data = queryDocumentSnapshot.data()
                let courseCode = data["courseCode"] as? String ?? ""
                let profMail = data["profMail"] as? String ?? ""
                let id = data["id"] as? String ?? ""
                return CourseProfessorsViewModel(id: id, courseCode: courseCode, profMail: profMail)
            }
        }
    }
}
