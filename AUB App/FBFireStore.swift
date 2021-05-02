//
//  FBFireStore.swift
//  AUB App
//
//  Created by Sara Darwish  on 19/03/2021.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


enum FBFirestore {

    static func retrieveFBUser(uid: String, completion: @escaping (Result<FBUser, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
        getDocument(for: reference) { (result) in
            switch result {
            case .success(let data):
                guard let user = FBUser(documentData: data) else {
                    completion(.failure(FireStoreError.noUser))
                    return
                }
                completion(.success(user))
            case .failure(let err):
                completion(.failure(err))
            }
        }
        
    }
    
    static func mergeFBUser(_ data: [String: Any], uid: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
        reference.setData(data, merge: true) { (err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }
    
    fileprivate static func getDocument(for reference: DocumentReference, completion: @escaping (Result<[String : Any], Error>) -> ()) {
        reference.getDocument { (documentSnapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let documentSnapshot = documentSnapshot else {
                completion(.failure(FireStoreError.noDocumentSnapshot))
                return
            }
            guard let data = documentSnapshot.data() else {
                completion(.failure(FireStoreError.noSnapshotData))
                return
            }
            completion(.success(data))
        }
    }
    
    static func addCourse(coursecode: String, name: String, department: String, description: String, faculty: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection("courses")
            .document(coursecode)
        
        reference.setData([
            "name": name,
            "code": coursecode,
            "description":description,
            "department": department,
            "faculty": faculty]) { (err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }
    
    static func addReview(id: String, name: String, email: String, review: String, timeDate: String, code: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let reference = Firestore.firestore()
            .collection("courseReview")
            .document(id)
            reference
            .setData([
                "id": id,
                "name" : name,
                "email" : email,
                "courseCode" : code,
                "review" : review,
                "timeDate" : timeDate]) { (err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }
    
    static func addProfessor(email: String, name: String, department: String, officeHours: String, faculty: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection("professors")
            .document(email)
        
        reference.setData([
            "name": name,
            "email": email,
            "officeHours": officeHours,
            "department": department,
            "faculty": faculty]) { (err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }
    
    static func addCourseProf(id: String, profMail: String, courseCode: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection("courseprof")
            .document(id)
        
        reference.setData([
            "id": id,
            "profMail": profMail,
            "courseCode": courseCode]) { (err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }

    
    static func addRate() {
        
    }

}
