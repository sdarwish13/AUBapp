//
//  ProfessorRatingsViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 07/05/2021.
//

import Foundation
import Firebase

class ProfessorRatingsViewModel: ObservableObject {
    @Published var ratings = [ProfessorRatingViewModel]()
    @Published var allRatings = 0
    @Published var professorRatings = 0
    
    private var db = Firestore.firestore()

    func fetchData(email: String) {
        
        db.collection("professorRating").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.allRatings = 0
            self.professorRatings = 0
            self.ratings = documents.map { (queryDocumentSnapshot) -> ProfessorRatingViewModel in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let profEmail = data["profEmail"] as? String ?? ""
                let userEmail = data["userEmail"] as? String ?? ""
                let myrating = data["myrating"] as? Int ?? 0
                let res = NSPredicate(format: "SELF MATCHES %@","\(email)[a-zA-Z0-9]+@mail.aub.edu").evaluate(with: "\(id)")
                if(res) {
                    self.allRatings += myrating
                    self.professorRatings += 1
                }
                return ProfessorRatingViewModel(id: id, profEmail: profEmail, userEmail: userEmail, myrating: myrating)
            }
        }
    }

}
