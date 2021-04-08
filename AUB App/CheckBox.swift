//
//  CheckBox.swift
//  AUB App
//
//  Created by Sara Darwish  on 17/03/2021.
//

import Foundation
import SwiftUI


struct CheckView: View {
    @State var isChecked : Bool = false
    var title : String
    let callback: (String, Bool)->()
    func toggle() {
        isChecked = !isChecked
    }
    var body: some View {
        Button(action: {
                toggle()
                self.callback(self.title, self.isChecked)}){
            HStack{
                Image(systemName: isChecked ? "checkmark.square": "square")
                Text(title)
            }.foregroundColor(Color(red: 0.4, green: 0.8, blue: 6))
        }
    }
}
