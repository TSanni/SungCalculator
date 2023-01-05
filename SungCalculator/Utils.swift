//
//  Utils.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import Foundation
import SwiftUI


extension Color {
    static var goodBlack: Color {
        return Color(red: 0.15, green: 0.15, blue: 0.15)
    }
}


extension Text {
    var addLine: Text {
        self + Text("|").font(.largeTitle).foregroundColor(.blue)
    }
}
