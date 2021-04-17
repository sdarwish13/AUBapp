//
//  CourseReview.swift
//  courses
//
//  Created by Ghina Kamal on 18/03/2021.
//

import SwiftUI


struct CourseReview: View {
    @State private var review: String = ""
    let verticalPaddingForForm = 40.0
    @State var text: String = ""
    var reviews: [Course]=[]
    @State private var showError = false
    @State private var errorString = ""
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        NavigationView {
            List {
                ForEach(testData){ review in
                    HStack(spacing:0){
                        Button(action: {
                            print("Delete button tapped!")
                        }) {
                            Image(systemName: "person.circle")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 0.4, green: 0.8, blue:8))
//                                .padding(.leading, 5)
                        }
                        VStack{
                            Text(review.code )
                                .bold()
                                .padding(.leading,-90)
                                .padding(.bottom, 3) // bottom padding
                            
                            Text(review.description)
                                .padding(.leading, 5)  //left padding
                        }

                        Spacer()
                    }
                }
            }
            .navigationTitle("Reviews")
            
        }
        VStack {
            TextField("Write a review here", text: $text)
                .fixedSize(horizontal: false, vertical: true)
                .frame(height: 80)
                .padding(.leading,5)
                .border(Color(red: 0.4, green: 0.8, blue:8),width: 2)

            HStack{
                
            Button(action: {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let timestamp = format.string(from: date)
                print("hello1")
                
                FBFirestore.addReview(email: userInfo.user.email, review: text, timeDate: timestamp){ (result) in
                        switch result {
                        case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                        case .success( _):
                            print("Review Course Created Successfully")
                        }
                    }
                print("hello2")
                
                
//                print(self.$text)
//                text=""
                
            }) {
                Text("Post")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.4, green: 0.8, blue:8))
                    .frame(width: 100.0, height: 30.0)
                    .border(Color(red: 0.4, green: 0.8, blue:8),width: 2)}
            
            Button(action: {
                text=""
            }) {
                Text("Clear")
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.4, green: 0.8, blue:8))
                    .multilineTextAlignment(.center)
                    .frame(width: 100.0, height: 30.0)
                    .border(Color(red: 0.4, green: 0.8, blue:8),width: 2)

            }
        }
      }
    }
}

struct CourseReview_Previews: PreviewProvider {
    static var previews: some View {
        CourseReview(reviews: testData)
    }
}
