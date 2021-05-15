//
//  ProfessorPage.swift
//  AUB App
//
//  Created by Ghina Kamal and Sara Darwish on 25/02/2021.
//


import Foundation
import SwiftUI
import Firebase


struct ProfessorPage: View {
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var rating = 0
    @EnvironmentObject var userInfo: UserInfo
    @State var ratings: ProfessorRatingsViewModel = ProfessorRatingsViewModel()
    @State var professor: ProfessorViewModel = ProfessorViewModel()
    @State var rate = false
    @State private var courserating = 0
    @State private var myrating : Int = 0
//    @State private var review: String = ""
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
            Firestore.firestore().collection("professorRating")
                .document("\(professor.email)\(userInfo.user.email)")
                .setData(["myrating" : self.myrating,
                          "userEmail" : userInfo.user.email,
                          "profEmail" : professor.email,
                          "id" : "\(professor.email)\(userInfo.user.email)"])
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                withAnimation { self.rate.toggle() }
            }) {
                VStack(alignment: .center, spacing: 8) {
                    RatingView(filled: myrating > 0)
                    Text(ratings.ratings.count>0 ? ratings.professorRatings>0 ? "\(ratings.allRatings/ratings.professorRatings)" : "Rate This" : "Rate This")
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 11, weight: .semibold, design: .rounded))
                }
            }
            .overlay(
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
            .padding(.top, 50)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("Email:")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("\(professor.email)")
                        .frame(height: 50)
                        .font(.custom("Helvetica Neue", size: 19))
                }
                
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("Office Hours:")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("\(professor.officeHours)")
                        .frame(height: 50)
                        .font(.custom("Helvetica Neue", size: 19))
                }
                
                HStack {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("Department:")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("\(professor.department)")
                        .frame(height: 50)
                        .font(.custom("Helvetica Neue", size: 19))
                }
                
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("Faculty:")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                    Text("\(professor.faculty)")
                        .frame(height: 50)
                        .font(.custom("Helvetica Neue", size: 19))
                }
            }
            Spacer()
            HStack {
                NavigationLink(destination: ProfessorCoursesList(professor: professor)) {
                    VStack {
                        Text("Courses")
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

                Button(action: {}) {
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
                
            }.padding(50)
        }.navigationTitle("\(professor.name)")
        .onAppear() {
            ratings.fetchData(email: professor.email)
            Firestore.firestore().collection("professorRating")
                .document("\(professor.email)\(userInfo.user.email)").getDocument { (document, error) in
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
//                        .document(professor.id).delete()
//                }) {
//                    Image(systemName: "trash")
//                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
//                }
//            }
//        }.disabled(userInfo.user.isadmin == 0)
    }
}

struct ProfessorPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfessorPage()
    }
}

