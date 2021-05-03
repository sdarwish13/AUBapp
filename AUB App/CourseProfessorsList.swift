//
//  CourseProfessorsList.swift
//  AUB App
//
//  Created by Sara Darwish  on 03/05/2021.
//

import SwiftUI
import FirebaseFirestore

struct CourseProfessorsList: View {
    @State private var showingSheet = false
    @State private var searchText : String = ""
    @State var course: CourseViewModel = CourseViewModel()
    @ObservedObject private var viewModel = ProfessorCoursesListViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    
                    ForEach(viewModel.courseprofs) { courseprof in
                        let res = NSPredicate(format: "SELF MATCHES %@","\(course.code)[a-zA-Z0-9]+@aub.edu.lb").evaluate(with: "\(courseprof.id)")
                        if(res) {
                            HStack {
                                HStack {
                                    Text("\(courseprof.profName)")
                                    Spacer()
                                }
                                Button(action: {
                                    Firestore.firestore().collection("courseprof").document("\(courseprof.courseCode)\(courseprof.profMail)").delete()
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                                }
                            }
                        }
                    }
                }.navigationTitle("All Courses")
                 .onAppear() {
                    self.viewModel.fetchData()
                 }
                 .toolbar {
                   ToolbarItemGroup(placement: .bottomBar) {
                       Spacer()
                       Button(action: {
                           showingSheet.toggle()
                       }) {
                           Image(systemName: "plus")
                               .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                       }.sheet(isPresented: $showingSheet) {
                           AddCourseProfessor(course: course)
                       }
                   }
                 }
                 .listStyle(PlainListStyle())
            }
        }
    }
}

struct CourseProfessorsList_Previews: PreviewProvider {
    static var previews: some View {
        CourseProfessorsList()
    }
}
