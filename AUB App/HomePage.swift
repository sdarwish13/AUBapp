//
//  HomePage.swift
//  AUB App
//
//  Created by Sara Darwish and Ghina Kamal  on 20/03/2021.
//

import SwiftUI
import Firebase

struct HomePage: View {
    @State var showMenu = false
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        let drag = DragGesture()
                    .onEnded {
                        if $0.translation.width < -100 {
                            withAnimation {
                                self.showMenu = false
                            }
                        }
                    }
        
        return NavigationView {
            GeometryReader { geometry in
            ZStack(alignment: .leading) {
                MainView(showMenu: self.$showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/1.5 : 0)
                    .disabled(self.showMenu ? true : false)
                        if self.showMenu {
                            MenuView()
                                .frame(width: geometry.size.width/1.5)
                                .transition(.move(edge: .leading))
                        }
                        }
                        .gesture(drag)
           
            
            }.navigationBarItems(trailing: Button("Log Out") {
                FBAuth.logout { (result) in
                    print("Logged Out")
                }
            })
            .navigationBarTitle("Home Page", displayMode: .inline)
            .navigationBarItems(leading: (
                                  Button(action: {
                                      withAnimation {
                                          self.showMenu.toggle()
                                      }
                                  }) {
                                      Image(systemName: "line.horizontal.3")
                                          .imageScale(.large)
                                  }
                              ))
          }.onAppear {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            FBFirestore.retrieveFBUser(uid: uid) { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let user):
                    self.userInfo.user = user
                }
            }
//                let data = [FBKeys.User.major: ""]
//                FBFirestore.mergeFBUser(data, uid: uid) { (result) in
//                    switch result {
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    case .success(_):
//                        print("merged successfully")
//                    }
//                }
        }

        
        
    }
}

struct MainView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        HStack{
            VStack{
                NavigationLink(destination: AllCoursesPage()){
                    VStack {
                        Image(systemName: "books.vertical")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                        Text("All Courses")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                            .font(.custom("Helvetica Neue", size: 21))
                    }
                }
                .frame(width: 180, height: 150)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(10)
                .border(Color(red: 0.4, green: 0.8, blue: 6),width:3)
                .padding(.bottom, 20)
            
            
                NavigationLink(destination: CurrentCoursesPage()){
                VStack {
                    Image(systemName: "book")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("Current Courses")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .font(.custom("Helvetica Neue", size: 21))
                }
            }
            .frame(width: 180, height: 150)
            .background(Color.white)
            .foregroundColor(Color.black)
            .cornerRadius(10)
            .border(Color(red: 0.4, green: 0.8, blue: 6),width:3)
                

        }
          
            
            VStack{
                
                NavigationLink(destination: AllProfessorsPage()){
                    VStack {
                        Image(systemName: "rectangle.stack.person.crop")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                        Text("All Professors")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                            .font(.custom("Helvetica Neue", size: 21))
                    }
                }
                .frame(width: 180, height: 150)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(10)
                .border(Color(red: 0.4, green: 0.8, blue: 6),width:3)
                .padding(.bottom, 20)
             
                
           
                
                NavigationLink(destination: StarredCoursesPage()){
                VStack {
                    Image(systemName: "star")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("Starred Courses")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .font(.custom("Helvetica Neue", size: 21))
                }
            }
            .frame(width: 180, height: 150)
            .background(Color.white)
            .foregroundColor(Color.black)
            .cornerRadius(10)
            .border(Color(red: 0.4, green: 0.8, blue: 6),width:3)
                
                
        }
            
            
        }
        
    }
 
}
    


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
