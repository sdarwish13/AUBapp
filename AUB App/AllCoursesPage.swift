//
//  AllCoursesPage.swift
//  AUB App
//
//  Created by Sara Darwish  on 17/02/2021.
//

import SwiftUI
import Firebase


var checkName = false
var checkCode = false
var checkDept = false

struct AllCoursesPage: View {
    @State private var showingSheet = false
    @State private var searchText : String = ""
    @EnvironmentObject var userInfo: UserInfo
    @ObservedObject private var viewModel = AllCoursesViewModel()
    
    
    
    
    var body: some View {
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
            Divider()
            Text("Top 10")
            Divider()
            List {
                ForEach(viewModel.courses.filter { course in
                    if(searchText.isEmpty) {
                        return true
                    }
                    else if(checkDept && !checkCode && !checkName) {
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
                        AddCourse()
                    }
                }
             }
             .listStyle(PlainListStyle())
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

struct AllCoursesPage_Previews: PreviewProvider {
    static var previews: some View {
        AllCoursesPage()
    }
}
