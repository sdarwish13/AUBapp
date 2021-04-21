//
//  CourseReviewViewModel.swift
//  AUB App
//
//  Created by Ghina Kamal on 17/04/2021.
//

import Foundation
import Firebase


class CourseReviewViewModel: ObservableObject {
    @Published var reviews = [ReviewViewModel]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("courseReview").order(by: "timeDate",descending: true)
           .addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
                
            }
          
            
            self.reviews = documents.map { (queryDocumentSnapshot) -> ReviewViewModel in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let review = data["review"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let courseCode = data["courseCode"] as? String ?? ""
                let timeDate = data["timeDate"] as? String ?? ""
                return ReviewViewModel( email: email, name: name, courseCode: courseCode, review: review, timeDate: timeDate)
            }
        }
    }

}
