//
//  CurrentCoursesPage.swift
//  AUB App
//
//  Created by Sara Darwish  on 19/04/2021.
//

import SwiftUI
import Firebase

struct CurrentCoursesPage: View {
    @State private var showingSheet = false
    @State private var searchText : String = ""
    @ObservedObject private var viewModel = CurrentCoursesViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search")
            List {
                ForEach(viewModel.courses.filter { course in
                    if(searchText.isEmpty) {
                        return true
                    }
                    return course.code.lowercased().contains(searchText.lowercased()) || course.name.lowercased().contains(searchText.lowercased()) || course.department.lowercased().contains(searchText.lowercased())
                }) { course in
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
            }.navigationTitle("Starred Courses")
            .onAppear() {
                self.viewModel.fetchData()
            }.listStyle(PlainListStyle())
        }
    }
}

struct CurrentCoursesPage_Previews: PreviewProvider {
    static var previews: some View {
        CurrentCoursesPage()
    }
}
