//
//  StarredCoursesPage.swift
//  AUB App
//
//  Created by Sara Darwish  on 16/04/2021.
//

import SwiftUI
import Firebase

struct StarredCoursesPage: View {
    @State private var showingSheet = false
    @ObservedObject private var viewModel = AllCoursesViewModel()
    
    
    var body: some View {
            VStack {
                
//                List(viewModel.courses) { course in
//                    VStack(alignment: .leading) {
//                        Text(course.name).font(.title)
//                        Text(course.code).font(.subheadline)
//                    }
//                }.navigationBarTitle("Users")
                
                List {
                    ForEach(viewModel.courses) { course in
                        NavigationLink(destination: CoursePage(course: course))
                        {
                            VStack {
                                HStack {
                                    Text("\(course.code)")
                                    Spacer()
                                }
                                HStack {
                                    Text("\(course.name)")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                                    Spacer()
                                }
                            }
                        }
                    }
                }.navigationTitle("All Courses")
                .onAppear() {
                    self.viewModel.fetchData()
                }.listStyle(PlainListStyle())
            }
    }
}

struct StarredCoursesPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        StarredCoursesPage()
        }
    }
}
