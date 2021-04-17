//
//  AddCourse.swift
//  AUB App
//
//  Created by Sara Darwish  on 29/03/2021.
//

import SwiftUI

struct AddCourse: View {
    @State var course: CourseViewModel = CourseViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    @State private var errorString = ""
    let verticalPaddingForForm = 40.0
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 0.8, blue: 6), .white]), center: .center, startRadius: 50, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    
                    VStack {
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter course code", text: self.$course.code)
                                    .foregroundColor(Color.black)
                                
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !course.validCodeText.isEmpty {
                                Text(course.validCodeText).font(.caption).foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter course name ", text: self.$course.name)
                                    .foregroundColor(Color.black)
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            
                            if !course.validNameText.isEmpty {
                                Text(course.validNameText).font(.caption).foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter course department", text: self.$course.department)
                                    .foregroundColor(Color.black)
                                
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            
                            if !course.validDepartmentText.isEmpty {
                                Text(course.validDepartmentText).font(.caption).foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter course faculty", text: self.$course.faculty)
                                    .foregroundColor(Color.black)
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !course.validFacultyText.isEmpty {
                                Text(course.validFacultyText).font(.caption).foregroundColor(.red)
                            }
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter course description", text: self.$course.description)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(Color.black)
                                    
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            
                        }
                    }
                    
                    Button(action: {
                        FBFirestore.addCourse(coursecode: course.code, name: course.name, department: course.department, description: course.description, faculty: course.faculty) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                            case .success( _):
                                print("Course Created Successfully")
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                    }) {
                        Text("Add Course")
                            .padding()
                            .frame(width: 200)
                            .opacity(course.isAddCourseComplete ? 1 : 0.75)
                        
                    }.background(Color(red: 0.4, green: 0.8, blue: 6))
                     .foregroundColor(.white)
                     .cornerRadius(10)
                     .disabled(!course.isAddCourseComplete)
                    
                }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            }.padding(.top, -54)
             .padding(.bottom, -54)
        
            
             .alert(isPresented: $showError) {
                Alert(title: Text("Error adding course"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
             }
             .navigationBarTitle("Add Course", displayMode: .inline)
             .navigationBarItems(trailing: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
             })
            
        }
    }
}

struct AddCourse_Previews: PreviewProvider {
    static var previews: some View {
        AddCourse()
    }
}
