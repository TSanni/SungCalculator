//
//  ContentView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var calculator = CalclutaorClass()
    
    var body: some View {
        CalculatorView()
            .environmentObject(calculator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CalclutaorClass())
        
        ContentView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            .environmentObject(CalclutaorClass())
    }
}
