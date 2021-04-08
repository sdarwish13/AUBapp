//
//  ContentView.swift
//  AUB App
//
//  Created by Sara Darwish  on 18/03/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userInfo : UserInfo
    var body: some View {
        Group {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading...")
            }
            else if userInfo.isUserAuthenticated == .signedOut {
                LoginView()
            }
            else {
                HomePage()
            }
        }
        .onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
