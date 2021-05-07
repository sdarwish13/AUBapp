//
//  RatingView.swift
//  AUB App
//
//  Created by Sara Darwish on 06/05/2021.
//

import Foundation
import SwiftUI

struct RatingView: View {
    var filled:Bool = true
    
    var body: some View {
        Image(systemName: filled ? "star.fill" : "star")
            .foregroundColor(filled ? Color.yellow : Color.black.opacity(0.6))
    }
}
