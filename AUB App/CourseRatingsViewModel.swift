//
//  CourseRatingsViewModel.swift
//  AUB App
//
//  Created by Sara Darwish  on 05/05/2021.
//

import Foundation
import Firebase

class CourseRatingsViewModel: ObservableObject {
    @Published var ratings = [CourseRatingViewModel]()
    @Published var allRatings = 0
    @Published var courseRatings = 0
    
    private var db = Firestore.firestore()

    func fetchData(code: String) {
        
        db.collection("courseRating").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.allRatings = 0
            self.courseRatings = 0
            self.ratings = documents.map { (queryDocumentSnapshot) -> CourseRatingViewModel in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let courseCode = data["courseCode"] as? String ?? ""
                let userEmail = data["userEmail"] as? String ?? ""
                let myrating = data["myrating"] as? Int ?? 0
                let res = NSPredicate(format: "SELF MATCHES %@","\(code)[a-zA-Z0-9]+@mail.aub.edu").evaluate(with: "\(id)")
                if(res) {
                    self.allRatings += myrating
                    self.courseRatings += 1
                }
                return CourseRatingViewModel(id: id, courseCode: courseCode, userEmail: userEmail, myrating: myrating)
            }
        }
    }

}
