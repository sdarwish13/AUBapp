//
//  FBUser.swift
//  AUB App
//
//  Created by Sara Darwish  on 19/03/2021.
//

import Foundation

struct FBUser {
    let uid: String
    let name: String
    let email: String
    let isadmin: Int
        
    init(uid: String, name: String, email: String, isadmin:Int) {
        self.uid = uid
        self.name = name
        self.email = email
        self.isadmin = isadmin
    }

}

extension FBUser {
    init?(documentData: [String : Any]) {
        let uid = documentData[FBKeys.User.uid] as? String ?? ""
        let name = documentData[FBKeys.User.name] as? String ?? ""
        let email = documentData[FBKeys.User.email] as? String ?? ""
        let isadmin = documentData[FBKeys.User.isadmin] as? Int ?? 0
        
        self.init(uid: uid, name: name, email: email, isadmin: isadmin)
    }
    
    static func dataDict(uid: String, name: String, email: String, isadmin: Int) -> [String: Any] {
        var data: [String: Any]
        
        if name != "" {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.name: name,
                FBKeys.User.email: email,
                FBKeys.User.isadmin: isadmin,
            ]
        }
        else {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.email: email,
                FBKeys.User.isadmin: isadmin,
            ]
        }
        return data
    }
}
