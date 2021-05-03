//
//  AllProfessorsPage.swift
//  AUB App
//
//  Created by Sara Darwish  on 17/04/2021.
//

import SwiftUI

struct AllProfessorsPage: View {
    @State private var showingSheet = false
    @State private var searchText : String = ""
    @EnvironmentObject var userInfo: UserInfo
    @ObservedObject private var viewModel = AllProfessorsViewModel()
    
    
    
    
    var body: some View {
        VStack {
//                List(viewModel.courses) { course in
//                    VStack(alignment: .leading) {
//                        Text(course.name).font(.title)
//                        Text(course.code).font(.subheadline)
//                    }
//                }.navigationBarTitle("Users")
            
            
            SearchBar(text: $searchText, placeholder: "Search")
            if(searchText.isEmpty) {
                Divider()
                Text("Top 10")
                Divider()
                List {
                    ForEach(viewModel.professors) { professor in
                        NavigationLink(destination: ProfessorPage(professor: professor))
                        {
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
                }.navigationTitle("All Professors")
                .onAppear() {
                    self.viewModel.limitFetch()
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
                            AddProfessor()
                        }
                    }
                 }
                 .listStyle(PlainListStyle())
            }
            else {
                List {
                    ForEach(viewModel.professors.filter { professor in
                        return professor.name.lowercased().contains(searchText.lowercased())
                    }) { professor in
                        NavigationLink(destination: ProfessorPage(professor: professor))
                        {
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
                }.navigationTitle("All Professors")
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
                            AddProfessor()
                        }
                    }
                 }
                 .listStyle(PlainListStyle())
            }
        }
    }
}

struct AllProfessorsPage_Previews: PreviewProvider {
    static var previews: some View {
        AllProfessorsPage()
    }
}
