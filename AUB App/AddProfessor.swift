//
//  AddProfessor.swift
//  AUB App
//
//  Created by Sara Darwish  on 17/04/2021.
//

import SwiftUI

struct AddProfessor: View {
    @State var professor: ProfessorViewModel = ProfessorViewModel()
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
                                TextField("Enter professor name", text: self.$professor.name)
                                    .foregroundColor(Color.black)
                                
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !professor.validNameText.isEmpty {
                                Text(professor.validNameText).font(.caption).foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter professor email ", text: self.$professor.email)
                                    .foregroundColor(Color.black)
                                    .autocapitalization(.none)
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !professor.validEmailText.isEmpty {
                                Text(professor.validEmailText).font(.caption).foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter professor department", text: self.$professor.department)
                                    .foregroundColor(Color.black)
                                
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !professor.validDepartmentText.isEmpty {
                                Text(professor.validDepartmentText).font(.caption).foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter professor faculty", text: self.$professor.faculty)
                                    .foregroundColor(Color.black)
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !professor.validFacultyText.isEmpty {
                                Text(professor.validFacultyText).font(.caption).foregroundColor(.red)
                            }
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                TextField("Enter professor office hours", text: self.$professor.officeHours)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(Color.black)
                                    
                            }.padding()
                             .background(Color.white)
                             .cornerRadius(10)
                            if !professor.validOfficeHText.isEmpty {
                                Text(professor.validOfficeHText).font(.caption).foregroundColor(.red)
                            }
                            
                        }
                    }
                    
                    Button(action: {
                        FBFirestore.addProfessor(email: professor.email, name: professor.name, department: professor.department, officeHours: professor.officeHours, faculty: professor.faculty) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                            case .success( _):
                                print("Professor Created Successfully")
                            }
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Professor")
                            .padding()
                            .frame(width: 200)
                            .opacity(professor.isAddProfessorComplete ? 1 : 0.75)
                        
                    }.background(Color(red: 0.4, green: 0.8, blue: 6))
                     .foregroundColor(.white)
                     .cornerRadius(10)
                     .disabled(!professor.isAddProfessorComplete)
                    
                }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            }.padding(.top, -54)
             .padding(.bottom, -54)
        
            
             .alert(isPresented: $showError) {
                Alert(title: Text("Error adding professor"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
             }
             .navigationBarTitle("Add Professor", displayMode: .inline)
             .navigationBarItems(trailing: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
             })
        }
    }
}

struct AddProfessor_Previews: PreviewProvider {
    static var previews: some View {
        AddProfessor()
    }
}
