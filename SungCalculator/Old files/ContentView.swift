//
//  ContentView.swift
//  SungCalculator
//
//  Created by Tomas Sanni on 12/26/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var calculator = CalclutaorClass.shared
    @StateObject var persistence = PersistenceController.shared
    
    var body: some View {
        CalculatorView()
            .environmentObject(calculator)
            .environmentObject(persistence)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CalclutaorClass.shared)
    }
}
