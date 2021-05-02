//
//  AllProfessorsViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 17/04/2021.
//

import Foundation
import Firebase

class AllProfessorsViewModel: ObservableObject {
    @Published var professors = [ProfessorViewModel]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("professors").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.professors = documents.map { (queryDocumentSnapshot) -> ProfessorViewModel in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let officeHours = data["officeHours"] as? String ?? ""
                let department = data["department"] as? String ?? ""
                let faculty = data["faculty"] as? String ?? ""
                return ProfessorViewModel(name: name, email: email, officeHours: officeHours, department: department, faculty: faculty)
            }
        }
    }

}
