//
//  RatingStars.swift
//  AUB App
//
//  Created by Ghina Kamal on 18/02/2021.
//

import Foundation
import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        }
        else {
            return onImage
        }
    }
}



//struct StarsView: View {
//    var rating: CGFloat
//    var maxRating: Int
//
//    var body: some View {
//        let stars = HStack(spacing: 0) {
//            ForEach(0..<maxRating) { _ in
//                Image(systemName: "star.fill")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }
//        }
//
//        stars.overlay(
//            GeometryReader { g in
//                let width = rating / CGFloat(maxRating) * g.size.width
//                ZStack(alignment: .leading) {
//                    Rectangle()
//                        .frame(width: width)
//                        .foregroundColor(.yellow)
//                }
//            }
//            .mask(stars)
//        )
//        .foregroundColor(.gray)
//    }
//}
