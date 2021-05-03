//
//  ProfessorPage.swift
//  AUB App
//
//  Created by Ghina Kamal and Sara Darwish on 25/02/2021.
//


import Foundation
import SwiftUI


struct ProfessorPage: View {
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var rating = 0
    @State var professor: ProfessorViewModel = ProfessorViewModel()
//    @State private var review: String = ""
    let verticalPaddingForForm = 120.0
    
    var body: some View {
        VStack(alignment: .center) {
            RatingView(rating: $rating)
                .padding()
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
    }
}

struct ProfessorPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfessorPage()
    }
}

