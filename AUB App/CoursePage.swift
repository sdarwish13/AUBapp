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
    @State var ratings: CourseRatingsViewModel = CourseRatingsViewModel()
    @EnvironmentObject var userInfo: UserInfo
    @State var rate = false
    @State private var courserating = 0
    @State private var myrating : Int = 0
    let verticalPaddingForForm = 120.0
    
    var gesture: some Gesture {
        let updateRating: (CGFloat)->() = { x in
            let percent = max((x / 110.0), 0.0)
            self.myrating = min(Int(percent * 5.0) + 1, 5)
        }
        return DragGesture(minimumDistance: 0, coordinateSpace: .local)
        .onChanged({ val in
            updateRating(val.location.x)
        })
        .onEnded { val in
            updateRating(val.location.x)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    self.rate = false
                }
            }
            Firestore.firestore().collection("courseRating")
                .document("\(course.code)\(userInfo.user.email)")
                .setData(["myrating" : self.myrating,
                          "userEmail" : userInfo.user.email,
                          "courseCode" : course.code,
                          "id" : "\(course.code)\(userInfo.user.email)"])
        }
    }
    
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
                    withAnimation { self.rate.toggle() }
                }) {
                    VStack(alignment: .center, spacing: 8) {
                        RatingView(filled: myrating > 0)
                        Text(ratings.ratings.count>0 ? ratings.courseRatings>0 ? "\(ratings.allRatings/ratings.courseRatings)" : "Rate This" : "Rate This")
                            .foregroundColor(Color.black)
                            .font(Font.system(size: 11, weight: .semibold, design: .rounded))
                    }
                }.overlay(
                    HStack(alignment: .center, spacing: 4) {
                        RatingView(filled: myrating > 0)
                        RatingView(filled: myrating > 1)
                        RatingView(filled: myrating > 2)
                        RatingView(filled: myrating > 3)
                        RatingView(filled: myrating > 4)
                    }.gesture(gesture)
                    .padding(.all, 12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                    .offset(x: 0, y: -45)
                    .opacity(rate ? 1.0 : 0)
                )
            }
                    
            Text("\(course.description)")
            .frame(width: 380, height: 280)
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
            ratings.fetchData(code: course.code)
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
            Firestore.firestore().collection("courseRating")
                .document("\(course.code)\(userInfo.user.email)").getDocument { (document, error) in
                    if let document = document {
                        if document.exists {
                            self.myrating = document.get("myrating") as! Int
                        } else {
                            self.myrating = 0
                        }
                }
            }
        }
//        .toolbar {
//            ToolbarItemGroup(placement: .bottomBar) {
//                Spacer()
//                Button(action: {
//                    Firestore.firestore().collection("courseReview")
//                        .document(course.id).delete()
//                }) {
//                    Image(systemName: "trash")
//                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
//                }
//            }
//        }.disabled(userInfo.user.isadmin == 0)
    }
}

struct CoursePage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CoursePage()
        }
    }
}
