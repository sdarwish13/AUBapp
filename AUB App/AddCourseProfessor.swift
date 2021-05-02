//
//  AddCourseProfessor.swift
//  AUB App
//
//  Created by Sara Darwish  on 02/05/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddCourseProfessor: View {
    @State var professor: ProfessorViewModel = ProfessorViewModel()
    @State private var searchText : String = ""
    @ObservedObject private var viewModel = AllCoursesViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    @State private var errorString = ""
    @State private var exist = false
    let verticalPaddingForForm = 40.0
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search")
                HStack {
                    Text("Search By:")
                        .padding(.leading, 20)
                        .padding(.bottom, 1)
                    Spacer()
                }
                HStack {
                    CheckView(isChecked: false, title: "Name", callback: checkboxSelected).padding(.leading, 20)
                    Spacer()
                    CheckView(isChecked: false, title: "Code", callback: checkboxSelected)
                    Spacer()
                    CheckView(isChecked: false, title: "Department", callback: checkboxSelected)
                    Spacer()
                }
                if(searchText.isEmpty) {
                    Divider()
                    Text("Top 10")
                    Divider()
                    List {
                        ForEach(viewModel.courses) { course in
                            Button(action: {
                                let id = "\(course.code)\(professor.email)"
                                Firestore.firestore().collection("courseprof").document(id)
                                    .setData(["id" : id,
                                              "profmail" : professor.email,
                                              "courseCode" : course.code])
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                HStack {
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
                        }
                    }.navigationTitle("All Courses")
                    .onAppear() {
                        self.viewModel.limitFetch()
                    }.listStyle(PlainListStyle())
                }
                else {
                    List {
                        ForEach(viewModel.courses.filter { course in
                            if(checkDept && !checkCode && !checkName) {
                                return course.department.lowercased().contains(searchText.lowercased())
                            }
                            else if(!checkDept && checkCode && !checkName) {
                                return course.code.lowercased().contains(searchText.lowercased())
                            }
                            else if(!checkDept && !checkCode && checkName) {
                                return course.name.lowercased().contains(searchText.lowercased())
                            }
                            else if(checkDept && checkCode && !checkName) {
                                return course.department.lowercased().contains(searchText.lowercased()) || course.code.lowercased().contains(searchText.lowercased())
                            }
                            else if(checkDept && !checkCode && checkName) {
                                return course.department.lowercased().contains(searchText.lowercased()) || course.name.lowercased().contains(searchText.lowercased())
                            }
                            else if(!checkDept && checkCode && checkName) {
                                return course.code.lowercased().contains(searchText.lowercased()) || course.name.lowercased().contains(searchText.lowercased())
                            }
                                return course.code.lowercased().contains(searchText.lowercased()) || course.name.lowercased().contains(searchText.lowercased()) || course.department.lowercased().contains(searchText.lowercased())
                        }) { course in
                            Button(action: {
                                let id = "\(course.code)\(professor.email)"
                                Firestore.firestore().collection("courseprof").document(id)
                                    .setData(["id" : id,
                                              "profmail" : professor.email,
                                              "courseCode" : course.code])
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                HStack {
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
                        }
                    }.navigationTitle("All Courses")
                    .onAppear() {
                        self.viewModel.fetchData()
                    }.listStyle(PlainListStyle())
                }
            }.navigationBarTitle("Add Course", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
               self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func checkboxSelected(id: String, isMarked: Bool) {
        if(id == "Name") {
           checkName = isMarked
        }
        if(id == "Code") {
            checkCode = isMarked
        }
        if(id == "Department") {
            checkDept = isMarked
        }
    }
}

struct AddCourseProfessor_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseProfessor()
    }
}
