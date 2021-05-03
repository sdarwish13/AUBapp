//
//  ProfessorCoursesList.swift
//  AUB App
//
//  Created by Sara Darwish  on 25/04/2021.
//

import SwiftUI
import FirebaseFirestore

struct ProfessorCoursesList: View {
    @State var professor: ProfessorViewModel = ProfessorViewModel()
    @State private var showingSheet = false
    @State private var searchText : String = ""
    @ObservedObject private var viewModel = ProfessorCoursesListViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    
                    ForEach(viewModel.courseprofs) { courseprof in
                        let res = NSPredicate(format: "SELF MATCHES %@","[A-Z]{4}[0-9]{3}[A-Z]?\(professor.email)").evaluate(with: "\(courseprof.id)")
                        
                        if(res) {
                            HStack {
                                Text("\(courseprof.courseCode)")
                                Spacer()
                                Button(action: {
                                    Firestore.firestore().collection("courseprof").document("\(courseprof.courseCode)\(professor.email)").delete()
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
                           AddProfessorCourse(professor: professor)
                       }
                   }
                 }
                 .listStyle(PlainListStyle())
            }
        }
    }
}

struct ProfessorCoursesList_Previews: PreviewProvider {
    static var previews: some View {
        ProfessorCoursesList()
    }
}
