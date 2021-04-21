//
//  DocumentsPage.swift
//  AUB App
//
//  Created by Sara Darwish  on 25/02/2021.
//

import SwiftUI

struct DocumentsPage: View {
    var documents: [Document] = []
    @State var course: CourseViewModel = CourseViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(documents) { document in
                    HStack {
                        Text("\(document.name)")
                          
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.down").foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                        }
                        Button(action: {}) {
                            Image(systemName: "icloud.and.arrow.up").foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
                        }
                    }
                }
            }.navigationTitle("Documents")
            .listStyle(PlainListStyle())
        }
    }
}

struct DocumentsPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DocumentsPage(documents: testData2)
        }
    }
}
