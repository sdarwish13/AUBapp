//
//  CourseProfessorsList.swift
//  AUB App
//
//  Created by Sara Darwish  on 25/04/2021.
//

import SwiftUI
import FirebaseFirestore

struct CourseProfessorsList: View {
    @State var professor: ProfessorViewModel = ProfessorViewModel()
    @State private var showingSheet = false
    @State private var searchText : String = ""
//    @EnvironmentObject var userInfo: UserInfo
    @ObservedObject private var viewModel = CourseProfessorsListViewModel()
    
    var body: some View {
        NavigationView{
        VStack {
            List {
                
                ForEach(viewModel.courseprofs) { courseprof in
                    let res = NSPredicate(format: "SELF MATCHES %@","[A-Z]{4}[0-9]{3}[A-Z]?\(professor.email)").evaluate(with: "\(courseprof.id)")
                    
                    if(res) {
                        HStack {
                            Text("\(courseprof.id)".prefix(7))
                            Spacer()
                        }
                    }
//                    let test = Firestore.firestore().collection("courses").document(courseprof.courseCode)
                    
                    
//                    let test =
//                        .map { (Query) -> CourseViewModel in
//                        let data = queryDocumentSnapshot.data()
//                        let name = data["name"] as? String ?? ""
//                        let code = data["code"] as? String ?? ""
//                        let department = data["department"] as? String ?? ""
//                        let description = data["description"] as? String ?? ""
//                        let faculty = data["faculty"] as? String ?? ""
//                        return CourseViewModel(code: code, name: name, description: description, department: department, faculty: faculty)
//                    }
                    
                    
//                    NavigationLink(destination: CoursePage(course: Firestore.firestore().collection("courses").document(courseprof.courseCode)))
//                    {
//
//                    }
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
                       AddCourseProfessor(professor: professor)
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
