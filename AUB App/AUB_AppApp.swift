//
//  AUB_AppApp.swift
//  AUB App
//
//  Created by Sara Darwish  on 17/02/2021.
//

import SwiftUI
import Firebase

@main
struct AUB_AppApp: App {
    
    init() {
        FirebaseApp.configure()
      }
    
    var body: some Scene {
        var userInfo = UserInfo()
        WindowGroup {
            ContentView().environmentObject(userInfo)
//            AllCoursesPage(courses: testData)
        }
    }
}
