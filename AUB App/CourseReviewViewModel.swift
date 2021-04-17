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
        db.collection("courseReviews")
            .document(Auth.auth().currentUser?.email ?? "").collection("myreviews").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.reviews = documents.map { (queryDocumentSnapshot) -> ReviewViewModel in
                let data = queryDocumentSnapshot.data()
                //email
                let review = data["review"] as? String ?? ""
                let courseCode = data["courseCode"] as? String ?? ""
                let timeDate = data["timeDate"] as? String ?? ""
                return ReviewViewModel(courseCode: courseCode, review: review, timeDate: timeDate)
            }
        }
    }

}
