//
//  AddCourseProfessor.swift
//  AUB App
//
//  Created by Sara Darwish  on 03/05/2021.
//

import SwiftUI
import FirebaseFirestore

struct AddCourseProfessor: View {
    @State var course: CourseViewModel = CourseViewModel()
    @State private var searchText : String = ""
    @ObservedObject private var viewModel = AllProfessorsViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    @State private var errorString = ""
    @State private var exist = false
    let verticalPaddingForForm = 40.0
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search")
                if(searchText.isEmpty) {
                    Divider()
                    Text("Top 10")
                    Divider()
                    List {
                        ForEach(viewModel.professors) { professor in
                            Button(action: {
                                let id = "\(course.code)\(professor.email)"
                                Firestore.firestore().collection("courseprof").document(id)
                                    .setData(["id" : id,
                                              "profMail" : professor.email,
                                              "courseCode" : course.code,
                                              "profName" : professor.name])
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                VStack {
                                    HStack {
                                        Text("\(professor.name)")
                                        Spacer()
                                    }
                                    HStack {
                                        Text("\(professor.email)")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                                        Spacer()
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
                        ForEach(viewModel.professors.filter { professor in
                            return professor.name.lowercased().contains(searchText.lowercased())
                        }) { professor in
                            Button(action: {
                                let id = "\(course.code)\(professor.email)"
                                Firestore.firestore().collection("courseprof").document(id)
                                    .setData(["id" : id,
                                              "profMail" : professor.email,
                                              "courseCode" : course.code,
                                              "profName" : professor.name])
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                VStack {
                                    HStack {
                                        Text("\(professor.name)")
                                        Spacer()
                                    }
                                    HStack {
                                        Text("\(professor.email)")
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
            }.navigationBarTitle("Add Course", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
               self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddCourseProfessor_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseProfessor()
    }
}
