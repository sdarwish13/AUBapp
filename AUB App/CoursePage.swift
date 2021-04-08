//
//  CoursePage.swift
//  AUB App
//
//  Created by Ghina Kamal on 18/02/2021.
//

import Foundation
import SwiftUI



struct CoursePage: View {
    @State var course: CourseViewModel = CourseViewModel()
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var isStarred: Bool = false
    @State private var rating = 0
    let verticalPaddingForForm = 120.0
    var body: some View {
            VStack(alignment: .center, spacing: 0.0) {
                HStack {
                    Button(action: {isStarred = !isStarred})
                    {
                        Image(systemName: isStarred ? "star.fill" : "star")
                            .font(.title)
                            .foregroundColor(Color(red: 0.4, green: 0.8, blue:8))
                    }.padding(.leading)
                    Spacer()
                    RatingView(rating: $rating)
                    Spacer()
                    Button(action: {})
                    {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .foregroundColor(Color(red: 0.4, green: 0.8, blue:8))
                    }.padding(.trailing)
                }.padding(.top, -60)
                        
                Text("\(course.description)")
                .frame(width: 380, height: 330)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom("Helvetica Neue", size: 19))
                
                HStack {
                    VStack {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
                        
                        NavigationLink(destination: DocumentsPage()) {
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
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
            }.navigationTitle("\(course.name)")
        }
}

struct CoursePage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CoursePage()
        }
    }
}
