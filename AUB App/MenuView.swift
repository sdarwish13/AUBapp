//
//  MenuView.swift
//  AUB App
//
//  Created by Ghina Kamal on 22/03/2021.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        VStack(alignment: .leading) {

                    HStack {
                        Text("\(userInfo.user.name)")
                            .foregroundColor(.white)
                            .font(.title)
                       
                    }
                    .padding(.top, 100)
            
                    HStack {
                        Text("\(userInfo.user.email)")
                            .foregroundColor(.white)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                           
                    }
                       
                    .padding(.top, 30)
                       
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        Text("Major")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                        .padding(.top, 30)
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        Text("Graduation Year")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                        .padding(.top, 30)
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        Text("CV")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.top, 30)
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 30)
            
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Button("Log Out") {
                        FBAuth.logout { (result) in
                            print("Logged Out")
                        }
                    }
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.top, 30)
                        Spacer()
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.4, green: 0.8, blue: 6))
                    .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
