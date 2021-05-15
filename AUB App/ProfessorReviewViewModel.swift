//
//  ProfessorReviewViewModel.swift
//  AUB App
//
//  Created by Ghina Kamal on 15/05/2021.
//

import SwiftUI
import Foundation
import Firebase

class ProfessorReviewViewModel: ObservableObject {
    @Published var reviews = [ReviewProfViewModel]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("professorReview").order(by: "timeDate", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
                    
            }
              
            self.reviews = documents.map { (queryDocumentSnapshot) -> ReviewProfViewModel in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let review = data["review"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let profEmail = data["profEmail"] as? String ?? ""
                let timeDate = data["timeDate"] as? String ?? ""
                return ReviewProfViewModel( id: id, email: email, name: name, profEmail: profEmail, review: review, timeDate: timeDate)
                }
            }
        }

    }
