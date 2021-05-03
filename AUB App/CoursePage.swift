//
//  CoursePage.swift
//  AUB App
//
//  Created by Ghina Kamal and Sara Darwish on 18/02/2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

var isStarred = false
var isCurrent = false

struct CoursePage: View {
    @State var course: CourseViewModel = CourseViewModel()
    @EnvironmentObject var userInfo: UserInfo
    @State private var rate = false
    @State private var courserating = 0
    @State private var myrating = 0
    let verticalPaddingForForm = 120.0
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            VStack {
                Text("\(course.name)").bold().foregroundColor(Color(red: 0.4, green: 0.8, blue:8))
                    .font(.title2)
                HStack {
                    Button(action: {
                        isCurrent.toggle()
                        if(isCurrent) {
                            Firestore.firestore().collection("current").document(userInfo.user.email)
                                .collection("mycourses").document(course.code)
                                .setData(["code" : course.code,
                                          "name" : course.name,
                                          "description" : course.description,
                                          "department" : course.department,
                                          "faculty" : course.faculty])
                        }
                        if(!isCurrent) {
                            Firestore.firestore().collection("current").document(userInfo.user.email)
                                .collection("mycourses").document(course.code)
                                .delete()
                        }
                    })
                    {
                        Text("Current")
                            .padding(5)
                            .font(.custom("Helvetica Neue", size: 20))
                            .foregroundColor(isCurrent ? Color(red: 0.4, green: 0.8, blue:8) : .black)
                            .overlay(
                                Capsule()
                                    .stroke(isCurrent ? Color(red: 0.4, green: 0.8, blue:8) : .black, lineWidth: 2)
                            )
                    }.padding(.leading)
                    Spacer()
                    HStack {
                        Button(action: {
                            isStarred.toggle()
                            if(isStarred) {
                                Firestore.firestore().collection("starred").document(userInfo.user.email)
                                    .collection("mycourses").document(course.code)
                                    .setData(["code" : course.code,
                                              "name" : course.name,
                                              "description" : course.description,
                                              "department" : course.department,
                                              "faculty" : course.faculty])
                            }
                            if(!isStarred) {
                                Firestore.firestore().collection("starred").document(userInfo.user.email)
                                    .collection("mycourses").document(course.code)
                                    .delete()
                            }
                        })
                        {
                            Image(systemName: isStarred ? "star.fill" : "star")
                                .font(.title)
                                .foregroundColor(isStarred ? Color(red: 0.4, green: 0.8, blue:8) : .black)
                        }.padding(5)
                    }
                }
                Button(action: {
                    withAnimation { self.rate = !self.rate }
                }) {
                    RatingView(rating: $courserating)
                        .disabled(true)
                }.overlay(
                    RatingView(rating: $myrating)
                        .padding(.all, 12)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                        .offset(x: 0, y: -40)
                        .opacity(rate ? 1.0 : 0)
                
                )
                
            }
                    
            Text("\(course.description)")
            .frame(width: 380, height: 330)
            .fixedSize(horizontal: false, vertical: true)
            .font(.custom("Helvetica Neue", size: 19))
            
            HStack {
                VStack {
                    Button(action: {}) {
                        VStack{
                            Text("Syllabus")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .font(.custom("Helvetica Neue", size: 21))
                            
                            Image(systemName: "chevron.right.circle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }
                    }
                    .frame(width: 180, height: 110)
                    .background(Color(red: 0.4, green: 0.8, blue: 6))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: CourseReview(course : course)) {
                        VStack{
                            Text("Documents")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .font(.custom("Helvetica Neue", size: 21))
                            
                            Image(systemName: "chevron.right.circle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }
                    }
                    .frame(width: 180, height: 110)
                    .background(Color(red: 0.4, green: 0.8, blue: 6))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
                VStack{
                    NavigationLink(destination: CourseReview(course : course)) {
                        VStack{
                    
                            Text("Reviews")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .font(.custom("Helvetica Neue", size: 21))
                            
                            Image(systemName: "chevron.right.circle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }
                    }
                    .frame(width: 180, height: 110)
                    .background(Color(red: 0.4, green: 0.8, blue: 6))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: CourseProfessorsList(course: course)) {
                        VStack {
                            Text("Professors")
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .font(.custom("Helvetica Neue", size: 21))
                            
                            Image(systemName: "chevron.right.circle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }
                    }
                    .frame(width: 180, height: 110)
                    .background(Color(red: 0.4, green: 0.8, blue: 6))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                }
            }
        }.navigationTitle("\(course.code)")
//             .alert(isPresented: $rate) {
//               Alert(title: Text("Error adding course"),
//                     message: Text("rate \(RatingView(rating: $myrating))"),
//                     dismissButton: .default(Text("OK"))
//               )
//             }
        .onAppear {
            Firestore.firestore().collection("starred")
                .document(userInfo.user.email).collection("mycourses")
                .document(course.code).getDocument { (document, error) in
                    if let document = document {
                        if document.exists {
                            isStarred = true
                        } else {
                            isStarred = false
                        }
                }
            }
            Firestore.firestore().collection("current")
                .document(userInfo.user.email).collection("mycourses")
                .document(course.code).getDocument { (document, error) in
                    if let document = document {
                        if document.exists {
                            isCurrent = true
                        } else {
                            isCurrent = false
                        }
                }
            }
        }
    }
}

struct CoursePage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CoursePage()
        }
    }
}
